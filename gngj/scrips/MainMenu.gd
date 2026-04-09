extends Control

@onready var start_button: Button = $MainMenu/CenterContainer/VBoxContainer/StartButton     # change paths to match your scene
@onready var load_button: Button = $MainMenu/CenterContainer/VBoxContainer/LoadButton  
@onready var options_button: Button = $MainMenu/CenterContainer/VBoxContainer/OptionsButton
@onready var credits_button: Button = $MainMenu/CenterContainer2/CreditsButton
@onready var exit_button: Button = $MainMenu/CenterContainer/VBoxContainer/ExitButton

@onready var testEndOfDayButton: Button = $testEndOfDay
@onready var testQuestListScreenButton: Button = $testQuestListScreen


signal startGame
signal displayOptions
signal displayCredits

signal testThatShit
signal testThatOtherShit

func _ready() -> void:
	start_button.pressed.connect(_on_menu_button_pressed.bind("start"))
	load_button.pressed.connect(_on_menu_button_pressed.bind("load"))
	options_button.pressed.connect(_on_menu_button_pressed.bind("options"))
	credits_button.pressed.connect(_on_menu_button_pressed.bind("credits"))
	exit_button.pressed.connect(_on_menu_button_pressed.bind("exit"))
	
	testEndOfDayButton.pressed.connect(_on_menu_button_pressed.bind("test1"))
	testQuestListScreenButton.pressed.connect(_on_menu_button_pressed.bind("test2"))
	


func _on_menu_button_pressed(button_name: String) -> void:
	match button_name:
		"start":
			startGame.emit()
		"load":
			print("Opening load menu...")
			
		"options":
			displayOptions.emit()
		"credits":
			displayCredits.emit()
		"exit":
			print("Exiting the game...")
			get_tree().quit()
		"test1":
			testThatShit.emit()
		"test2":
			testThatOtherShit.emit()
