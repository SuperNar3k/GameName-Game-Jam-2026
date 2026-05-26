extends Control


# Makin every alphabetical button 
@onready var aButton: TextureButton = $Book/aButton
@onready var cButton: TextureButton = $Book/cButton
@onready var eButton: TextureButton = $Book/eButton
@onready var gButton: TextureButton = $Book/gButton
@onready var iButton: TextureButton = $Book/iButton
@onready var kButton: TextureButton = $Book/kButton
@onready var mButton: TextureButton = $Book/mButton
@onready var bButton: TextureButton = $Book/bButton
@onready var dButton: TextureButton = $Book/dButton
@onready var fButton: TextureButton = $Book/fButton
@onready var hButton: TextureButton = $Book/hButton
@onready var jButton: TextureButton = $Book/jButton
@onready var lButton: TextureButton = $Book/lButton
@onready var nButton: TextureButton = $Book/nButton
@onready var pButton: TextureButton = $Book/pButton
@onready var rButton: TextureButton = $Book/rButton
@onready var tButton: TextureButton = $Book/tButton
@onready var vButton: TextureButton = $Book/vButton
@onready var xButton: TextureButton = $Book/xButton
@onready var zButton: TextureButton = $Book/zButton
@onready var oButton: TextureButton = $Book/oButton
@onready var qButton: TextureButton = $Book/qButton
@onready var sButton: TextureButton = $Book/sButton
@onready var uButton: TextureButton = $Book/uButton
@onready var wButton: TextureButton = $Book/wButton
@onready var yButton: TextureButton = $Book/yButton


signal enable_outside_buttons
signal stopAnimation
signal backButtonPressed

var allPotions : Dictionary # Dictionary of all potions
var allIngredients : Dictionary # Dictionary of all ingredients
var potionKeysSorted : Array # Array of all potion keys, sorted
var tableOfContents : Dictionary # Dictionary (keys are all 26 letters, values are the page_index for that letter)

var page_index : int = 0 # Int representing the current page index

#used to prevent double presses for buttons
var backPressed = false
var fwdPressed = false

func _ready() -> void:
	hide()
	$ExitBtn.mouse_entered.connect(_on_hovered.bind($Sprite2D, true))
	$ExitBtn.mouse_exited.connect(_on_hovered.bind($Sprite2D, false))
	$BackBtn.mouse_entered.connect(_on_hovered.bind($backimg, true))
	$BackBtn.mouse_exited.connect(_on_hovered.bind($backimg, false))
	$FwdBtn.mouse_entered.connect(_on_hovered.bind($fwdimg, true))
	$FwdBtn.mouse_exited.connect(_on_hovered.bind($fwdimg, false))
	
	var buttonRecipeArray = $Book.get_children()
	
	aButton.pressed.connect(_go_to_page.bind("A"))
	bButton.pressed.connect(_go_to_page.bind("B"))
	cButton.pressed.connect(_go_to_page.bind("C"))
	dButton.pressed.connect(_go_to_page.bind("D"))
	eButton.pressed.connect(_go_to_page.bind("E"))
	fButton.pressed.connect(_go_to_page.bind("F"))
	gButton.pressed.connect(_go_to_page.bind("G"))
	hButton.pressed.connect(_go_to_page.bind("H"))
	iButton.pressed.connect(_go_to_page.bind("I"))
	jButton.pressed.connect(_go_to_page.bind("J"))
	kButton.pressed.connect(_go_to_page.bind("K"))
	lButton.pressed.connect(_go_to_page.bind("L"))
	mButton.pressed.connect(_go_to_page.bind("M"))
	nButton.pressed.connect(_go_to_page.bind("N"))
	oButton.pressed.connect(_go_to_page.bind("O"))
	pButton.pressed.connect(_go_to_page.bind("P"))
	qButton.pressed.connect(_go_to_page.bind("Q"))
	rButton.pressed.connect(_go_to_page.bind("R"))
	sButton.pressed.connect(_go_to_page.bind("S"))
	tButton.pressed.connect(_go_to_page.bind("T"))
	uButton.pressed.connect(_go_to_page.bind("U"))
	vButton.pressed.connect(_go_to_page.bind("V"))
	wButton.pressed.connect(_go_to_page.bind("W"))
	xButton.pressed.connect(_go_to_page.bind("X"))
	yButton.pressed.connect(_go_to_page.bind("Y"))
	zButton.pressed.connect(_go_to_page.bind("Z"))
	
	# Set font of Recipe Buttons
	for i in buttonRecipeArray:
		i.add_theme_font_override("font", load("res://assets/fonts/ArefRuqaaInk-Regular.ttf"))

func __init__(
	_allPotions : Dictionary,
	_allIngredients : Dictionary
) -> void:
	# Set global dictionaries
	allPotions = _allPotions
	allIngredients = _allIngredients
	
	# Sort the keys
	potionKeysSorted = allPotions.keys()
	potionKeysSorted.sort()
		
	
	# Initialize tableOfContents array
	var lastIndex = 0
	for c in range(ord("a"), ord("z") + 1):
		var letter:String = String.chr(c).to_upper()
		for p in range(lastIndex, potionKeysSorted.size()) :
			if potionKeysSorted[p].begins_with(letter):
				tableOfContents.set(letter, p)
				lastIndex = p 
				break
		tableOfContents.set(letter, lastIndex)


func _go_to_page(c : String):
	var indexToGoTo = tableOfContents.get(c)
	
	# If index is odd, make it even based on its relative positive to page_index
	if indexToGoTo % 2 == 1:
		indexToGoTo -= 1
	
	#	if indexToGoTo > page_index:
	#		indexToGoTo += 1
	#	else:
	#		indexToGoTo -= 1
	
	while indexToGoTo != page_index:
		if indexToGoTo > page_index:
			_on_fwd_btn_pressed()
			page_index = page_index-1
		else:
			_on_back_btn_pressed()

func _on_hovered(ref, hovered:bool):
	ref.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)

func _on_recipe_book_btn_pressed() -> void:
	
	#Need this for the tutorial unfortunetly
	stopAnimation.emit()
	
	
	$bookopen.play()
	#Displays the first set of recipes
	page_index =  0
	while page_index < 2:
		if (allPotions.get(potionKeysSorted[page_index]).unlocked):
			if (page_index % 2 == 0):
				$LeftSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index]).sprite))
				$LeftSprite/LeftDesc.text = allPotions.get(potionKeysSorted[page_index]).description
				$LeftSprite/LeftName.text = allPotions.get(potionKeysSorted[page_index]).itemName
				for j in allPotions.get(potionKeysSorted[page_index]).recipe:
					var newLabel = Label.new()
					newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index]).sprite))
				$RightSprite/RightDesc.text = allPotions.get(potionKeysSorted[page_index]).description
				$RightSprite/RightName.text = allPotions.get(potionKeysSorted[page_index]).itemName
				for j in allPotions.get(potionKeysSorted[page_index]).recipe:
					var newLabel = Label.new()
					newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (page_index % 2 == 0):
				$LeftSprite.set_texture(Texture2D)
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for j in allPotions.get(potionKeysSorted[page_index]).recipe:
					var newLabel = Label.new()
					newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(Texture2D)
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for ingred in allPotions.get(potionKeysSorted[page_index]).recipe:
					var newLabel = Label.new()
					newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		page_index = page_index + 1
					
	page_index = 0
	$AnimationPlayer.play("slide_up")
	show()


func _on_fwd_btn_pressed() -> void:
	fwdPressed = true
	var randPitch = (randf_range(0.8, 1.2))
	$paper.pitch_scale = randPitch
	$paper.play(.41)
	#delete previous page infos
	for child in $LeftSprite/LeftRecipe.get_children():
		child.queue_free()
	for child in $RightSprite/RightRecipe.get_children():
		child.queue_free()
	$LeftSprite/LeftName.text = ""
	$LeftSprite/LeftDesc.text = ""
	$LeftSprite.set_texture(null)
	$RightSprite/RightName.text = ""
	$RightSprite/RightDesc.text = ""
	$RightSprite.set_texture(null)
	
	
	
	$BackBtn.show()
	$backimg.show()
	
	if(page_index%2 == 0):
		page_index += 1
	
	var iStore = page_index + 2
	var newLabel
	while page_index < iStore:
		page_index += 1
		if(page_index < allPotions.size()):
			if (allPotions.values()[page_index].unlocked):
				if (page_index % 2 == 0):
					$LeftSprite.set_texture(load(allPotions.values()[page_index].sprite))
					$LeftSprite/LeftDesc.text = allPotions.values()[page_index].description
					$LeftSprite/LeftName.text = allPotions.values()[page_index].itemName

					for j in allPotions.values()[page_index].recipe:
						newLabel = Label.new()
						newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = allIngredients.get(j).itemName
						$LeftSprite/LeftRecipe.add_child(newLabel)
				else:
					$RightSprite.set_texture(load(allPotions.values()[page_index].sprite))
					$RightSprite/RightDesc.text = allPotions.values()[page_index].description
					$RightSprite/RightName.text = allPotions.values()[page_index].itemName

					for j in allPotions.values()[page_index].recipe:
						newLabel = Label.new()
						newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = allIngredients.get(j).itemName
						$RightSprite/RightRecipe.add_child(newLabel)
			else:
				if (page_index % 2 == 0):
					$LeftSprite.set_texture(Texture2D)
					$LeftSprite/LeftDesc.text = "???"
					$LeftSprite/LeftName.text = "???"

					for ingred in allPotions.values()[page_index].recipe:
						newLabel = Label.new()
						newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = "???"
						$LeftSprite/LeftRecipe.add_child(newLabel)
				else:
					$RightSprite.set_texture(Texture2D)
					$RightSprite/RightDesc.text = "???"
					$RightSprite/RightName.text = "???"

					for ingred in allPotions.values()[page_index].recipe:
						newLabel = Label.new()
						newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = "???"
						$RightSprite/RightRecipe.add_child(newLabel)
		else:
			break
		
	if page_index == allPotions.size() or page_index == allPotions.size()-1:
		$FwdBtn.hide()
		$fwdimg.hide()


func _on_back_btn_pressed() -> void:
	backPressed = true
	var randPitch = (randf_range(0.8, 1.2))
	$paper.pitch_scale = randPitch
	$paper.play(.41)
	#delete previous recipe labels
	for child in $LeftSprite/LeftRecipe.get_children():
		child.queue_free()
	for child in $RightSprite/RightRecipe.get_children():
		child.queue_free()
	$LeftSprite/LeftName.text = ""
	$LeftSprite/LeftDesc.text = ""
	$LeftSprite.set_texture(null)
	$RightSprite/RightName.text = ""
	$RightSprite/RightDesc.text = ""
	$RightSprite.set_texture(null)
	
	$FwdBtn.show()
	$fwdimg.show()
	
	
	if(page_index%2 != 0):
		page_index = page_index-1 
	
	var iStore = page_index - 2
	var newLabel
		
	while page_index > iStore:
		page_index = page_index-1
		if allPotions.values()[page_index].unlocked:
			if (page_index % 2 == 0):
				$LeftSprite.set_texture(load(allPotions.values()[page_index].sprite))
				$LeftSprite/LeftDesc.text = allPotions.values()[page_index].description
				$LeftSprite/LeftName.text = allPotions.values()[page_index].itemName
				for j in allPotions.values()[page_index].recipe:
					newLabel = Label.new()
					newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(allPotions.values()[page_index].sprite))
				$RightSprite/RightDesc.text = allPotions.values()[page_index].description
				$RightSprite/RightName.text = allPotions.values()[page_index].itemName
				for j in allPotions.values()[page_index].recipe:
					newLabel = Label.new()
					newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (page_index % 2 == 0):
				$LeftSprite.set_texture(Texture2D)
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for j in allPotions.values()[page_index].recipe:
					newLabel = Label.new()
					newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(Texture2D)
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for j in allPotions.values()[page_index].recipe:
					newLabel = Label.new()
					newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		
	if page_index == 0:
		$BackBtn.hide()
		$backimg.hide()

func _on_exit_btn_pressed() -> void:
	if $ExitBtn.is_visible_in_tree() or $Book.position.y < 540:
		
		$ExitBtn.hide()
		$Sprite2D.hide()
		$FwdBtn.hide()
		$fwdimg.hide()
		$BackBtn.hide()
		$backimg.hide()
		
		#Need this too. Sorry >.<
		backButtonPressed.emit()
		$AnimationPlayer.play_backwards()
		

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if $Book.position.y == 540:
		
		page_index =  0
		backPressed = false
		fwdPressed = false
		for child in $LeftSprite/LeftRecipe.get_children():
			child.queue_free()
		for child in $RightSprite/RightRecipe.get_children():
			child.queue_free()
		enable_outside_buttons.emit()
		hide()
	else:
		$ExitBtn.show()
		$Sprite2D.show()
		$FwdBtn.show()
		$fwdimg.show()
