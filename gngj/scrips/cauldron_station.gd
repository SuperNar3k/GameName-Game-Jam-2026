extends Control

@onready var backButton : Button = $BackButton

signal goBack

var allPotions
var allIngredients

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	backButton.pressed.connect(_on_backButton_pressed)

func __init__(_allPotions : Dictionary, _allIngredients : Dictionary) -> void:
	# Set global dictionaries
	allPotions = _allPotions
	allIngredients = _allIngredients
	$IngredientDrawer.__init__(_allIngredients)

func _on_backButton_pressed() -> void:
	goBack.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_hovered(hovered: bool) -> void:
	$IngredientDrawer.material.set_shader_parameter("outline_thickness", 5.0 if hovered else 0.0)
