extends Control

@onready var backButton : Button = $BackButton

signal goBack

var huh = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$IngredientDrawer/Handle.mouse_entered.connect(_on_hovered.bind(true))
	$IngredientDrawer/Handle.mouse_exited.connect(_on_hovered.bind(false))
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

func _on_hovered(hovered: bool) -> void:
	$IngredientDrawer.material.set_shader_parameter("outline_thickness", 5.0 if hovered else 0.0)
