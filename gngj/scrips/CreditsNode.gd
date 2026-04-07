extends Control   # Change to your root node type if it's not Control

@onready var back_button: Button = $CenterContainer2/BackButton   # Adjust path if BackButton is deeper

func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed() -> void:
	print("Returning to main menu...")
	await get_tree().create_timer(0.15).timeout   # Small delay so button press feels responsive
	get_tree().change_scene_to_file("res://Scenes/MainMenuScene.tscn")   # ← Make sure this path is correct
