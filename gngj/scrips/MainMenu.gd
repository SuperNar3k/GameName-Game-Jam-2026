extends Control

@onready var start_button: Button = $MainMenu/CenterContainer/VBoxContainer/StartButton     # change paths to match your scene
@onready var load_button: Button = $MainMenu/CenterContainer/VBoxContainer/LoadButton  
@onready var options_button: Button = $MainMenu/CenterContainer/VBoxContainer/OptionsButton
@onready var credits_button: Button = $MainMenu/CenterContainer2/CreditsButton
@onready var exit_button: Button = $MainMenu/CenterContainer/VBoxContainer/ExitButton

signal startGame
signal displayOptions
signal displayCreadits

func _ready() -> void:
	start_button.pressed.connect(_on_menu_button_pressed.bind("start"))
	load_button.pressed.connect(_on_menu_button_pressed.bind("load"))
	options_button.pressed.connect(_on_menu_button_pressed.bind("options"))
	credits_button.pressed.connect(_on_menu_button_pressed.bind("credits"))
	exit_button.pressed.connect(_on_menu_button_pressed.bind("exit"))


func _on_menu_button_pressed(button_name: String) -> void:
	match button_name:
		"start":
			startGame.emit()
		"load":
			print("Opening load menu...")
			
		"options":
			displayOptions.emit()
		"credits":
			pass
		"exit":
			print("Exiting the game...")
			get_tree().quit()
