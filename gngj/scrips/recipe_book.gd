extends Control

signal enable_outside_buttons

var allPotions : Dictionary
var allIngredients : Dictionary

var i = 0

#used to prevent double presses for buttons
var backPressed = false
var fwdPressed = false

func _ready() -> void:
	hide()

func _on_recipe_book_btn_pressed(_potions: Dictionary, _ingredients: Dictionary) -> void:
	allPotions = _potions
	allIngredients = _ingredients
	i = 0
	#displays the first set of recipes
	while i < 2:
		if (allPotions.values()[i].unlocked):
			if (i % 2 == 0):
				$LeftSprite.set_texture(load(allPotions.values()[i].sprite))
				$LeftSprite/LeftDesc.text = allPotions.values()[i].description
				$LeftSprite/LeftName.text = allPotions.values()[i].itemName
				for j in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = allIngredients.values()[j].itemName
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(allPotions.values()[i].sprite))
				$RightSprite/RightDesc.text = allPotions.values()[i].description
				$RightSprite/RightName.text = allPotions.values()[i].itemName
				for j in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = allIngredients.values()[j].itemName
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (i % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for j in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for ingred in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		i = i + 1
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
		i += 2
		backPressed = false
	var iStore = i + 2
	while i < iStore:
		if (allPotions.values()[i].unlocked):
			if (i % 2 == 0):
				$LeftSprite.set_texture(load(allPotions.values()[i].sprite))
				$LeftSprite/LeftDesc.text = allPotions.values()[i].description
				$LeftSprite/LeftName.text = allPotions.values()[i].itemName

				for j in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = allIngredients.values()[j].itemName
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(allPotions.values()[i].sprite))
				$RightSprite/RightDesc.text = allPotions.values()[i].description
				$RightSprite/RightName.text = allPotions.values()[i].itemName

				for j in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = allIngredients.values()[j].itemName
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (i % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"

				for ingred in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"

				for ingred in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		i = i + 1
	if i == allPotions.size():
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
		i -= 2
		fwdPressed = false
	var iStore = i - 2
	while i > iStore:
		i = i - 1
		if (allPotions.values()[i].unlocked):
			if (i % 2 == 0):
				$LeftSprite.set_texture(load(allPotions.values()[i].sprite))
				$LeftSprite/LeftDesc.text = allPotions.values()[i].description
				$LeftSprite/LeftName.text = allPotions.values()[i].itemName
				for j in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = allIngredients.values()[j].itemName
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(allPotions.values()[i].sprite))
				$RightSprite/RightDesc.text = allPotions.values()[i].description
				$RightSprite/RightName.text = allPotions.values()[i].itemName
				for j in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = allIngredients.values()[j].itemName
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (i % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for j in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for j in allPotions.values()[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		
	if i == 0:
		$BackBtn.hide()


func _on_exit_btn_pressed() -> void:
	$AnimationPlayer.play_backwards()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if $ExitBtn.is_visible_in_tree():
		$ExitBtn.hide()
		$FwdBtn.hide()
		$BackBtn.hide()
		i = 0
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
