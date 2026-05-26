extends Control

@onready var backButton : Button = $backButton

signal goBack

func _ready() -> void:
	backButton.pressed.connect(_on_backButton_pressed)

func _on_backButton_pressed() -> void: 
	goBack.emit()
	
	
func _process(_delta: float) -> void:
	pass
