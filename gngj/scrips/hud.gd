extends Control

signal recipe_pressed
signal quest_pressed
signal options_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_recipes_pressed() -> void:
	recipe_pressed.emit()


func _on_quests_pressed() -> void:
	quest_pressed.emit()


func _on_bookshelf_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	options_pressed.emit()
