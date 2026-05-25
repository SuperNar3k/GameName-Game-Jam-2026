extends Control

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
	$ExitBtn.mouse_entered.connect(_on_hovered.bind($Sprite2D, true))
	$ExitBtn.mouse_exited.connect(_on_hovered.bind($Sprite2D, false))
	$BackBtn.mouse_entered.connect(_on_hovered.bind($backimg, true))
	$BackBtn.mouse_exited.connect(_on_hovered.bind($backimg, false))
	$FwdBtn.mouse_entered.connect(_on_hovered.bind($fwdimg, true))
	$FwdBtn.mouse_exited.connect(_on_hovered.bind($fwdimg, false))

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

func _create_button(pot_index) -> void:
	var content_button = Button.new()
	content_button.text = allPotions.get(potionKeysSorted[pot_index]).itemName
	$TableofContents/AspectRatioContainer/VBoxContainer.add_child(content_button)
	content_button.pressed.connect(_go_to_page.bind(pot_index))

func _go_to_page(given_index : int):
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
	
	# If index is odd, make it even based on its relative positive to page_index
	if given_index % 2 == 1:
		given_index -= 1
	if given_index != page_index:
		page_index = given_index
	
	if (allPotions.get(potionKeysSorted[page_index]).unlocked):
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
		$LeftSprite.set_texture(Texture2D)
		$LeftSprite/LeftDesc.text = "???"
		$LeftSprite/LeftName.text = "???"
		for j in allPotions.get(potionKeysSorted[page_index]).recipe:
			var newLabel = Label.new()
			newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			newLabel.add_theme_color_override("font_color", "black")
			newLabel.text = "???"
			$LeftSprite/LeftRecipe.add_child(newLabel)
	
	if (allPotions.get(potionKeysSorted[page_index+1]).unlocked):
		$RightSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index+1]).sprite))
		$RightSprite/RightDesc.text = allPotions.get(potionKeysSorted[page_index+1]).description
		$RightSprite/RightName.text = allPotions.get(potionKeysSorted[page_index+1]).itemName
		for j in allPotions.get(potionKeysSorted[page_index+1]).recipe:
			var newLabel = Label.new()
			newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			newLabel.add_theme_color_override("font_color", "black")
			newLabel.text = j
			$RightSprite/RightRecipe.add_child(newLabel)

	else:
		$RightSprite.set_texture(Texture2D)
		$RightSprite/RightDesc.text = "???"
		$RightSprite/RightName.text = "???"
		for ingred in allPotions.get(potionKeysSorted[page_index+1]).recipe:
			var newLabel = Label.new()
			newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			newLabel.add_theme_color_override("font_color", "black")
			newLabel.text = "???"
			$RightSprite/RightRecipe.add_child(newLabel)

func _on_hovered(ref, hovered:bool):
	ref.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)

func _on_recipe_book_btn_pressed() -> void:
	$bookopen.play()
	#Checks pages until an unlocked page is found
	page_index =  0
	var page_found = false
	while page_found == false:
		if (!allPotions.get(potionKeysSorted[page_index]).unlocked) and (!allPotions.get(potionKeysSorted[page_index + 1]).unlocked):
			page_index += 2
		else:
			page_found = true
	
	_go_to_page(page_index)
	#var max_page = page_index + 2
	#Displays the first set of recipes
	#if (allPotions.get(potionKeysSorted[page_index]).unlocked):
		#$LeftSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index]).sprite))
		#$LeftSprite/LeftDesc.text = allPotions.get(potionKeysSorted[page_index]).description
		#$LeftSprite/LeftName.text = allPotions.get(potionKeysSorted[page_index]).itemName
		#for j in allPotions.get(potionKeysSorted[page_index]).recipe:
			#var newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = j
			#$LeftSprite/LeftRecipe.add_child(newLabel)
	#
	#else:
		#$LeftSprite.set_texture(Texture2D)
		#$LeftSprite/LeftDesc.text = "???"
		#$LeftSprite/LeftName.text = "???"
		#for j in allPotions.get(potionKeysSorted[page_index]).recipe:
			#var newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = "???"
			#$LeftSprite/LeftRecipe.add_child(newLabel)
	#
	#if (allPotions.get(potionKeysSorted[page_index+1]).unlocked):
		#$RightSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index+1]).sprite))
		#$RightSprite/RightDesc.text = allPotions.get(potionKeysSorted[page_index+1]).description
		#$RightSprite/RightName.text = allPotions.get(potionKeysSorted[page_index+1]).itemName
		#for j in allPotions.get(potionKeysSorted[page_index+1]).recipe:
			#var newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = j
			#$RightSprite/RightRecipe.add_child(newLabel)
#
	#else:
		#$RightSprite.set_texture(Texture2D)
		#$RightSprite/RightDesc.text = "???"
		#$RightSprite/RightName.text = "???"
		#for ingred in allPotions.get(potionKeysSorted[page_index+1]).recipe:
			#var newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = "???"
			#$RightSprite/RightRecipe.add_child(newLabel)
				
	$AnimationPlayer.play("slide_up")
	show()


func _on_fwd_btn_pressed() -> void:
	fwdPressed = true
	
	$BackBtn.show()
	$backimg.show()
	
	#if(page_index%2 == 0):
		#page_index += 1
	if(page_index + 2 < allPotions.size()):
		page_index += 2
	var page_found = false
	while page_found == false and page_index < allPotions.size() - 1:
		if (!allPotions.get(potionKeysSorted[page_index]).unlocked) and (!allPotions.get(potionKeysSorted[page_index + 1]).unlocked):
			page_index += 2
		else:
			page_found = true
	
	_go_to_page(page_index)
	#print(allPotions.values()[page_index].itemName)
	#var iStore = page_index + 2
	#var newLabel

	#if (allPotions.values()[page_index].unlocked):
		#$LeftSprite.set_texture(load(allPotions.values()[page_index].sprite))
		#$LeftSprite/LeftDesc.text = allPotions.values()[page_index].description
		#$LeftSprite/LeftName.text = allPotions.values()[page_index].itemName
#
		#for j in allPotions.values()[page_index].recipe:
			#newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = allIngredients.get(j).itemName
			#$LeftSprite/LeftRecipe.add_child(newLabel)
	#
	#else:
		#if (page_index % 2 == 0):
			#$LeftSprite.set_texture(Texture2D)
			#$LeftSprite/LeftDesc.text = "???"
			#$LeftSprite/LeftName.text = "???"
		#
		#for ingred in allPotions.values()[page_index].recipe:
			#newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = "???"
			#$LeftSprite/LeftRecipe.add_child(newLabel)
	#
	#
	#if (allPotions.values()[page_index+1].unlocked):
		#$RightSprite.set_texture(load(allPotions.values()[page_index+1].sprite))
		#$RightSprite/RightDesc.text = allPotions.values()[page_index+1].description
		#$RightSprite/RightName.text = allPotions.values()[page_index+1].itemName
#
		#for j in allPotions.values()[page_index+1].recipe:
			#newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = allIngredients.get(j).itemName
			#$RightSprite/RightRecipe.add_child(newLabel)
#
	#else:
		#$RightSprite.set_texture(Texture2D)
		#$RightSprite/RightDesc.text = "???"
		#$RightSprite/RightName.text = "???"
#
		#for ingred in allPotions.values()[page_index+1].recipe:
			#newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = "???"
			#$RightSprite/RightRecipe.add_child(newLabel)
	#else:
		#break
	#if (page_index < allPotions.size()-1):
		#page_index += 1
	#else:
		#break
	
	
	page_found = false
	var temp_index = page_index + 1
	while page_found == false and temp_index < allPotions.size()-1:
		if (!allPotions.get(potionKeysSorted[temp_index+1]).unlocked):
			temp_index += 1
		else:
			page_found = true
	if !page_found:
		$FwdBtn.hide()
		$fwdimg.hide()


func _on_back_btn_pressed() -> void:
	backPressed = true
	#var randPitch = (randf_range(0.8, 1.2))
	#$paper.pitch_scale = randPitch
	#$paper.play(.41)
	##delete previous recipe labels
	#for child in $LeftSprite/LeftRecipe.get_children():
		#child.queue_free()
	#for child in $RightSprite/RightRecipe.get_children():
		#child.queue_free()
	#$LeftSprite/LeftName.text = ""
	#$LeftSprite/LeftDesc.text = ""
	#$LeftSprite.set_texture(null)
	#$RightSprite/RightName.text = ""
	#$RightSprite/RightDesc.text = ""
	#$RightSprite.set_texture(null)
	
	$FwdBtn.show()
	$fwdimg.show()
	
	
	#if(page_index%2 != 0):
		#page_index = page_index-1 
	if(page_index - 2 >= 0):
		page_index -= 2
		
	var page_found = false
	while page_found == false and page_index >= 0:
		if (!allPotions.get(potionKeysSorted[page_index]).unlocked) and (!allPotions.get(potionKeysSorted[page_index + 1]).unlocked):
			page_index -= 2
		else:
			page_found = true
	#print(allPotions.values()[page_index].itemName)
	#var iStore = page_index - 2
	#var newLabel
	
	_go_to_page(page_index)
	#if allPotions.values()[page_index].unlocked:
		#$LeftSprite.set_texture(load(allPotions.values()[page_index].sprite))
		#$LeftSprite/LeftDesc.text = allPotions.values()[page_index].description
		#$LeftSprite/LeftName.text = allPotions.values()[page_index].itemName
		#for j in allPotions.values()[page_index].recipe:
			#newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = j
			#$LeftSprite/LeftRecipe.add_child(newLabel)
		#
	#else:
		#$LeftSprite.set_texture(Texture2D)
		#$LeftSprite/LeftDesc.text = "???"
		#$LeftSprite/LeftName.text = "???"
		#
		#for j in allPotions.values()[page_index].recipe:
			#newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = "???"
			#$LeftSprite/LeftRecipe.add_child(newLabel)
		#
		#
	#if allPotions.values()[page_index+1].unlocked:
		#$RightSprite.set_texture(load(allPotions.values()[page_index+1].sprite))
		#$RightSprite/RightDesc.text = allPotions.values()[page_index+1].description
		#$RightSprite/RightName.text = allPotions.values()[page_index+1].itemName
		#for j in allPotions.values()[page_index+1].recipe:
			#newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = j
			#$RightSprite/RightRecipe.add_child(newLabel)
	#
	#else:
		#$RightSprite.set_texture(Texture2D)
		#$RightSprite/RightDesc.text = "???"
		#$RightSprite/RightName.text = "???"
		#for j in allPotions.values()[page_index+1].recipe:
			#newLabel = Label.new()
			#newLabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
			#newLabel.add_theme_color_override("font_color", "black")
			#newLabel.text = "???"
			#$RightSprite/RightRecipe.add_child(newLabel)
		#page_index = page_index-1
		
	page_found = false
	var temp_index = page_index - 1
	while page_found == false and temp_index >= 0:
		if (!allPotions.get(potionKeysSorted[temp_index]).unlocked):
			temp_index -= 1
		else:
			page_found = true
	if !page_found:
		$BackBtn.hide()
		$backimg.hide()

func _on_exit_btn_pressed() -> void:
	if $ExitBtn.is_visible_in_tree() or $Book.position.y < 540:
		$AnimationPlayer.play_backwards()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if $Book.position.y == 540:
		$ExitBtn.hide()
		$Sprite2D.hide()
		$FwdBtn.hide()
		$fwdimg.hide()
		$BackBtn.hide()
		$backimg.hide()
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
		
		var page_found = false
		var temp_index = page_index + 2
		while page_found == false and temp_index < allPotions.size():
			if (!allPotions.get(potionKeysSorted[temp_index]).unlocked):
				temp_index += 1
			else:
				page_found = true
				$FwdBtn.show()
				$fwdimg.show()
		
		page_found = false
		temp_index = page_index - 2
		while page_found == false and temp_index >= 0:
			if (!allPotions.get(potionKeysSorted[temp_index]).unlocked):
				temp_index -= 1
			else:
				page_found = true
				$BackBtn.show()
				$backimg.show()
		#$FwdBtn.show()
		#$fwdimg.show()
