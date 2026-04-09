extends Control
@onready var backButton : Button = $BackButton

signal goBack

var huh = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	backButton.pressed.connect(_on_backButton_pressed)

func _on_backButton_pressed() -> void:
	goBack.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_handle_pressed() -> void:
	if (huh % 2 == 0):
		$AnimationPlayer.play("Drawer_Slide")
		huh = huh + 1
	else:
		$AnimationPlayer.play_backwards("Drawer_Slide")
		huh = huh + 1
