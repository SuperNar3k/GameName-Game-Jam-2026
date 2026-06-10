extends Control

@onready var start_button: Button = $MainMenu/CenterContainer/VBoxContainer/StartButton     # change paths to match your scene
@onready var load_button: Button = $MainMenu/CenterContainer/VBoxContainer/LoadButton  
@onready var options_button: Button = $MainMenu/CenterContainer/VBoxContainer/OptionsButton
@onready var credits_button: Button = $MainMenu/CenterContainer2/CreditsButton
@onready var exit_button: Button = $MainMenu/CenterContainer/VBoxContainer/ExitButton


@onready var testEndOfDayButton: Button = $testEndOfDay


signal startGame
signal loadGame
signal displayOptions
signal displayCredits

signal testThatShit

func _ready() -> void:
	#$ColorRect.hide()
	$gameFileSelectScreen/save1/selectButton.mouse_entered.connect(got_hovered.bind(1, true))
	$gameFileSelectScreen/save1/selectButton.mouse_exited.connect(got_hovered.bind(1, false))
	$gameFileSelectScreen/save2/selectButton.mouse_entered.connect(got_hovered.bind(2, true))
	$gameFileSelectScreen/save2/selectButton.mouse_exited.connect(got_hovered.bind(2, false))
	$gameFileSelectScreen/save3/selectButton.mouse_entered.connect(got_hovered.bind(3, true))
	$gameFileSelectScreen/save3/selectButton.mouse_exited.connect(got_hovered.bind(3, false))
	$phys_buttons.open_button_pressed.connect(_on_menu_button_pressed.bind("start"))
	$phys_buttons.options_button_pressed.connect(_on_menu_button_pressed.bind("options"))
	$phys_buttons.credits_button_pressed.connect(_on_menu_button_pressed.bind("credits"))
	$phys_buttons.close_button_pressed.connect(_on_menu_button_pressed.bind("exit"))
	$gameFileSelectScreen/newGameButton.pressed.connect(onGameSelectScreenButtonPressed.bind("new game"))
	$gameFileSelectScreen/loadGameButton.pressed.connect(onGameSelectScreenButtonPressed.bind("load game"))
	
	
	
	#start_button.pressed.connect(_on_menu_button_pressed.bind("start"))
	#load_button.pressed.connect(_on_menu_button_pressed.bind("load"))
	#options_button.pressed.connect(_on_menu_button_pressed.bind("options"))
	#credits_button.pressed.connect(_on_menu_button_pressed.bind("credits"))
	#exit_button.pressed.connect(_on_menu_button_pressed.bind("exit"))
	#
	#testEndOfDayButton.pressed.connect(_on_menu_button_pressed.bind("test1"))
	
	
func got_hovered(savnum: int, hovered: bool):
	if savnum == 1:
		$gameFileSelectScreen/save1.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
	if savnum == 2:
		$gameFileSelectScreen/save2.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
	if savnum == 3:
		$gameFileSelectScreen/save3.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
	else:
		pass

func _on_menu_button_pressed(button_name: String) -> void:
	match button_name:
		"start":
			gameSelectScreen()
			
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

func phys_button_pressed():
	pass

func gameSelectScreen():
	$bg.hide()
	$phys_buttons.hide()
	$Sprite2D.hide()
	$ColorRect.show()
	$AnimationPlayer.play("fade_to_normal")
	$gameFileSelectScreen.show()
	
	if FileAccess.file_exists("user://pp.save"):
		$gameFileSelectScreen/loadGameButton.show()
	
func onGameSelectScreenButtonPressed(option : String):
	match option: 
		"new game":
			startGame.emit()
		"load game":
			loadGame.emit()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$ColorRect.hide()
