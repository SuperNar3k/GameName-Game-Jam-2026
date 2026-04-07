extends Control

var potions
var ingredients

func _ready() -> void:
	hide()

func _on_recipe_book_btn_pressed(_potions, _ingredients) -> void:
	potions = _potions
	ingredients = _ingredients
	var i = 0
	while i < 2:
		if (potions[i].unlocked):
			if (i % 2 == 0):
				$LeftSprite.set_texture(load(potions[i].sprite))
				$LeftSprite/LeftDesc.text = potions[i].description
				$LeftSprite/LeftName.text = potions[i].itemName
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.text = ingredients[ingred].itemName
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load(potions[i].sprite))
				$RightSprite/RightDesc.text = potions[i].description
				$RightSprite/RightName.text = potions[i].itemName
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.text = ingredients[ingred].itemName
					$RightSprite/RightRecipe.add_child(newLabel)
		else:
			if (i % 2 == 0):
				$LeftSprite.set_texture(load("res://assets/icon.svg"))
				$LeftSprite/LeftDesc.text = "???"
				$LeftSprite/LeftName.text = "???"
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.text = "???"
					$LeftSprite/LeftRecipe.add_child(newLabel)
			else:
				$RightSprite.set_texture(load("res://assets/icon.svg"))
				$RightSprite/RightDesc.text = "???"
				$RightSprite/RightName.text = "???"
				for ingred in potions[i].recipe:
					var newLabel = Label.new()
					newLabel.text = "???"
					$RightSprite/RightRecipe.add_child(newLabel)
		i = i + 1
	
	show()
