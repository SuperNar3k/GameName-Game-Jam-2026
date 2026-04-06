extends Control

@onready var start_button: Button = $CenterContainer/VBoxContainer/StartButton     # change paths to match your scene
@onready var load_button: Button = $CenterContainer/VBoxContainer/LoadButton  
@onready var options_button: Button = $CenterContainer/VBoxContainer/OptionsButton
@onready var credits_button: Button = $CenterContainer2/CreditsButton
@onready var exit_button: Button = $CenterContainer/VBoxContainer/ExitButton

func _ready() -> void:
	# Connect each button and pass a unique string so we know which one was pressed
	start_button.pressed.connect(_on_menu_button_pressed.bind("start"))
	load_button.pressed.connect(_on_menu_button_pressed.bind("load"))
	options_button.pressed.connect(_on_menu_button_pressed.bind("options"))
	credits_button.pressed.connect(_on_menu_button_pressed.bind("credits"))
	exit_button.pressed.connect(_on_menu_button_pressed.bind("exit"))


func _on_menu_button_pressed(button_name: String) -> void:
	match button_name:
		"start":
			print("Starting the game...")
			get_tree().change_scene_to_file("res://game_scene.tscn")   # ← change to your actual game scene path
		"load":
			print("Opening load menu...")
			# get_tree().change_scene_to_file("res://options_menu.tscn")  or show a popup
		"options":
			print("Opening options menu...")
			# get_tree().change_scene_to_file("res://options_menu.tscn")  or show a popup
		"credits":
			print("Showing credits...")
			# get_tree().change_scene_to_file("res://credits.tscn") or show a panel
		"exit":
			print("Exiting the game...")
			get_tree().quit()
