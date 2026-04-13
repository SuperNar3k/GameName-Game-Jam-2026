extends Control


#makin every fuckin button work 
@onready var aButton : Button = $Book/aButton
@onready var bButton : Button = $Book/bButton
@onready var cButton : Button = $Book/cButton
@onready var dButton : Button = $Book/dButton
@onready var eButton : Button = $Book/eButton
@onready var fButton : Button = $Book/fButton
@onready var gButton : Button = $Book/gButton
@onready var hButton : Button = $Book/hButton
@onready var iButton : Button = $Book/iButton
@onready var jButton : Button = $Book/jButton
@onready var kButton : Button = $Book/kButton
@onready var lButton : Button = $Book/lButton
@onready var mButton : Button = $Book/mButton
@onready var nButton : Button = $Book/nButton
@onready var oButton : Button = $Book/oButton
@onready var pButton : Button = $Book/pButton
@onready var qButton : Button = $Book/qButton
@onready var rButton : Button = $Book/rButton
@onready var sButton : Button = $Book/sButton
@onready var tButton : Button = $Book/tButton
@onready var uButton : Button = $Book/uButton
@onready var vButton : Button = $Book/vButton
@onready var wButton : Button = $Book/wButton
@onready var xButton : Button = $Book/xButton
@onready var yButton : Button = $Book/yButton
@onready var zButton : Button = $Book/zButton


signal enable_outside_buttons

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
	
	#TESTING ONLY CODE WILL BREAK SHIT
	for potion in allPotions.values():
		potion.unlocked = true
	
	
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
		
	print("table of contents created")


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
			print(page_index)


func _on_recipe_book_btn_pressed() -> void:
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
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index]).sprite))
				$RightSprite/RightDesc.text = allPotions.get(potionKeysSorted[page_index]).description
				$RightSprite/RightName.text = allPotions.get(potionKeysSorted[page_index]).itemName
				for j in allPotions.get(potionKeysSorted[page_index]).recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (page_index % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for j in allPotions.get(potionKeysSorted[page_index]).recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for ingred in allPotions.get(potionKeysSorted[page_index]).recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		page_index = page_index + 1
					
	page_index = 0
	$AnimationPlayer.play("slide_up")
	show()


func _on_fwd_btn_pressed() -> void:
	fwdPressed = true
	
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
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = allIngredients.get(j).itemName
						$LeftSprite/LeftRecipe.add_child(newLabel)
				else:
					$RightSprite.set_texture(load(allPotions.values()[page_index].sprite))
					$RightSprite/RightDesc.text = allPotions.values()[page_index].description
					$RightSprite/RightName.text = allPotions.values()[page_index].itemName

					for j in allPotions.values()[page_index].recipe:
						newLabel = Label.new()
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = allIngredients.get(j).itemName
						$RightSprite/RightRecipe.add_child(newLabel)
			else:
				if (page_index % 2 == 0):
					$LeftSprite.set_texture(load("res://assets/icon.svg"))
					$LeftSprite/LeftDesc.text = "???"
					$LeftSprite/LeftName.text = "???"

					for ingred in allPotions.values()[page_index].recipe:
						newLabel = Label.new()
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = "???"
						$LeftSprite/LeftRecipe.add_child(newLabel)
				else:
					$RightSprite.set_texture(load("res://assets/icon.svg"))
					$RightSprite/RightDesc.text = "???"
					$RightSprite/RightName.text = "???"

					for ingred in allPotions.values()[page_index].recipe:
						newLabel = Label.new()
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = "???"
						$RightSprite/RightRecipe.add_child(newLabel)
		else:
			break
		
	print(page_index)	
	if page_index == allPotions.size() or page_index == allPotions.size()-1:
		$FwdBtn.hide()


func _on_back_btn_pressed() -> void:
	backPressed = true
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
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(allPotions.values()[page_index].sprite))
				$RightSprite/RightDesc.text = allPotions.values()[page_index].description
				$RightSprite/RightName.text = allPotions.values()[page_index].itemName
				for j in allPotions.values()[page_index].recipe:
					newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (page_index % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for j in allPotions.values()[page_index].recipe:
					newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for j in allPotions.values()[page_index].recipe:
					newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		
		
	print(page_index)
	if page_index == 0:
		$BackBtn.hide()

func _on_exit_btn_pressed() -> void:
	$AnimationPlayer.play_backwards()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if $ExitBtn.is_visible_in_tree():
		$ExitBtn.hide()
		$FwdBtn.hide()
		$BackBtn.hide()
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
		$FwdBtn.show()
