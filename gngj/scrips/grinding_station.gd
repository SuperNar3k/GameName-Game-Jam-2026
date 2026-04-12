extends Control
@onready var backButton : Button = $BackButton

signal goBack

var allIngredients

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	backButton.pressed.connect(_on_backButton_pressed)
	
func __init__(_allIngredients : Dictionary) -> void:
	# Set global dictionaries
	allIngredients = _allIngredients
	$IngredientDrawer.__init__(_allIngredients)
	
func _on_backButton_pressed() -> void:
	goBack.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_hovered(hovered: bool, ref) -> void:
	ref.material.set_shader_parameter("outline_thickness", 5.0 if hovered else 0.0)


func _on_drop_spot_pressed() -> void:
	if ($IngredientDrawer.held == 1):
		$fruitBowl.texture = $IngredientDrawer.instance.texture
		$IngredientDrawer.instance.queue_free()
		$IngredientDrawer.held = null
	
