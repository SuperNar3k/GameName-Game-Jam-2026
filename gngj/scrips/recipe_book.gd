extends Control

signal enable_outside_buttons

var potions
var ingredients

var i = 0

#used to prevent double presses for buttons
var backPressed = false
var fwdPressed = false

func _ready() -> void:
	hide()

func _on_recipe_book_btn_pressed(_potions, _ingredients) -> void:
	potions = _potions
	ingredients = _ingredients
	i = 0
	#displays the first set of recipes
	while i < 2:
		if (potions[i].unlocked):
			if (i % 2 == 0):
				$LeftSprite.set_texture(load(potions[i].sprite))
				$LeftSprite/LeftDesc.text = potions[i].description
				$LeftSprite/LeftName.text = potions[i].itemName
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = ingredients[ingred].itemName
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(potions[i].sprite))
				$RightSprite/RightDesc.text = potions[i].description
				$RightSprite/RightName.text = potions[i].itemName
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = ingredients[ingred].itemName
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (i % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for ingred in potions[i].recipe:
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
		if (potions[i].unlocked):
			if (i % 2 == 0):
				$LeftSprite.set_texture(load(potions[i].sprite))
				$LeftSprite/LeftDesc.text = potions[i].description
				$LeftSprite/LeftName.text = potions[i].itemName

				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = ingredients[ingred].itemName
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(potions[i].sprite))
				$RightSprite/RightDesc.text = potions[i].description
				$RightSprite/RightName.text = potions[i].itemName

				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = ingredients[ingred].itemName
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (i % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"

				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"

				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		i = i + 1
	if i == potions.size():
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
		if (potions[i].unlocked):
			if (i % 2 == 0):
				$LeftSprite.set_texture(load(potions[i].sprite))
				$LeftSprite/LeftDesc.text = potions[i].description
				$LeftSprite/LeftName.text = potions[i].itemName
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = ingredients[ingred].itemName
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(potions[i].sprite))
				$RightSprite/RightDesc.text = potions[i].description
				$RightSprite/RightName.text = potions[i].itemName
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = ingredients[ingred].itemName
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (i % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.add_theme_color_override("font_color", "black")
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for ingred in potions[i].recipe:
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
