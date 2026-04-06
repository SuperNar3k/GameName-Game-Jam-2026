extends Control

var potions

func _ready() -> void:
	hide()

func _on_recipe_book_btn_pressed(_potions) -> void:
	potions = _potions
	show()
