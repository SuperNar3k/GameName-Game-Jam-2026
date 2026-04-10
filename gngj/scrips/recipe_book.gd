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
	for c in range(ord("a"), ord("z") + 1):
		var i = 0
		var letter:String = String.chr(c)
		for pot in potionKeysSorted:
			if pot.begins_with(letter):
				tableOfContents.set(letter, i)
			i += 1

func _go_to_page(c : String):
	var indexToGoTo = tableOfContents.get(c)
	
	# If index is odd, make it even based on its relative positive to page_index
	if indexToGoTo % 2 == 1:
		if indexToGoTo > page_index:
			indexToGoTo += 1
		else:
			indexToGoTo -= 1
	
	while indexToGoTo != page_index:
		if indexToGoTo > page_index:
			_on_fwd_btn_pressed()
			print(page_index)
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
		page_index =  page_index + 1
	$AnimationPlayer.play("slide_up")
	show()


func _on_fwd_btn_pressed() -> void:
	fwdPressed = true
	#delete previous recipe labels
	for child in $LeftSprite/LeftRecipe.get_children():
		child.queue_free()
	for child in $RightSprite/RightRecipe.get_children():
		child.queue_free()
	$BackBtn.show()
	if backPressed:
		page_index += 2
		backPressed = false

	var iStore = page_index + 2
	var newLabel
	while page_index < iStore:
		if(page_index < potionKeysSorted.size()):
			if (allPotions.get(potionKeysSorted[page_index]).unlocked):
				if (page_index % 2 == 0):
					$LeftSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index]).sprite))
					$LeftSprite/LeftDesc.text = allPotions.get(potionKeysSorted[page_index]).description
					$LeftSprite/LeftName.text = allPotions.get(potionKeysSorted[page_index]).itemName

					for j in allPotions.get(potionKeysSorted[page_index]).recipe:
						newLabel = Label.new()
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = allIngredients.get(j).itemName
						$LeftSprite/LeftRecipe.add_child(newLabel)
				else:
					$RightSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index]).sprite))
					$RightSprite/RightDesc.text = allPotions.get(potionKeysSorted[page_index]).description
					$RightSprite/RightName.text = allPotions.get(potionKeysSorted[page_index]).itemName

					for j in allPotions.get(potionKeysSorted[page_index]).recipe:
						newLabel = Label.new()
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = allIngredients.get(j).itemName
						$RightSprite/RightRecipe.add_child(newLabel)
			else:
				if (page_index % 2 == 0):
					$LeftSprite.set_texture(load("res://assets/icon.svg"))
					$LeftSprite/LeftDesc.text = "???"
					$LeftSprite/LeftName.text = "???"

					for ingred in allPotions.get(potionKeysSorted[page_index]).recipe:
						newLabel = Label.new()
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = "???"
						$LeftSprite/LeftRecipe.add_child(newLabel)
				else:
					$RightSprite.set_texture(load("res://assets/icon.svg"))
					$RightSprite/RightDesc.text = "???"
					$RightSprite/RightName.text = "???"

					for ingred in allPotions.get(potionKeysSorted[page_index]).recipe:
						newLabel = Label.new()
						newLabel.add_theme_color_override("font_color", "black")
						newLabel.text = "???"
						$RightSprite/RightRecipe.add_child(newLabel)
		else:
			break
			
		page_index = page_index + 1
	if page_index == allPotions.size():
		$FwdBtn.hide()


func _on_back_btn_pressed() -> void:
	backPressed = true
	#delete previous recipe labels
	for child in $LeftSprite/LeftRecipe.get_children():
		child.queue_free()
	for child in $RightSprite/RightRecipe.get_children():
		child.queue_free()
	$FwdBtn.show()
	if fwdPressed:
		page_index -= 2
		fwdPressed = false
	
	if(page_index%2 != 0):
		page_index = page_index-1 
	
	var iStore = page_index - 2
	var newLabel
		
	while page_index > iStore:
		page_index = page_index-1
			
		if (allPotions.get(potionKeysSorted[page_index]).unlocked):
			if (page_index % 2 == 0):
				$LeftSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index]).sprite))
				$LeftSprite/LeftDesc.text = allPotions.get(potionKeysSorted[page_index]).description
				$LeftSprite/LeftName.text = allPotions.get(potionKeysSorted[page_index]).itemName
				for j in allPotions.get(potionKeysSorted[page_index]).recipe:
					newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(allPotions.get(potionKeysSorted[page_index]).sprite))
				$RightSprite/RightDesc.text = allPotions.get(potionKeysSorted[page_index]).description
				$RightSprite/RightName.text = allPotions.get(potionKeysSorted[page_index]).itemName
				for j in allPotions.get(potionKeysSorted[page_index]).recipe:
					newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = j
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (page_index % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for j in allPotions.get(potionKeysSorted[page_index]).recipe:
					newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for j in allPotions.get(potionKeysSorted[page_index]).recipe:
					newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		
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
