extends Control
@onready var backButton : Button = $BackButton

signal goBack

var huh = 0
var held = null
var spawn_test = preload("res://Scenes/Spawn_Test.tscn")
var instance
var allIngredients

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$IngredientDrawer/Handle.mouse_entered.connect(_on_hovered.bind(true))
	$IngredientDrawer/Handle.mouse_exited.connect(_on_hovered.bind(false))
	backButton.pressed.connect(_on_backButton_pressed)
	
	
	
	$IngredientDrawer/Button.pressed.connect(_on_drawer_button_pressed.bind(1))
	$IngredientDrawer/Button2.pressed.connect(_on_drawer_button_pressed.bind(2))
	$IngredientDrawer/Button3.pressed.connect(_on_drawer_button_pressed.bind(3))
	$IngredientDrawer/Button4.pressed.connect(_on_drawer_button_pressed.bind(4))
	$IngredientDrawer/Button5.pressed.connect(_on_drawer_button_pressed.bind(5))
	$IngredientDrawer/Button6.pressed.connect(_on_drawer_button_pressed.bind(6))
	$IngredientDrawer/Button7.pressed.connect(_on_drawer_button_pressed.bind(7))
	$IngredientDrawer/Button8.pressed.connect(_on_drawer_button_pressed.bind(8))
	$IngredientDrawer/Button9.pressed.connect(_on_drawer_button_pressed.bind(9))
	$IngredientDrawer/Button10.pressed.connect(_on_drawer_button_pressed.bind(10))
	$IngredientDrawer/Button11.pressed.connect(_on_drawer_button_pressed.bind(11))
	$IngredientDrawer/Button12.pressed.connect(_on_drawer_button_pressed.bind(12))
	$IngredientDrawer/Button13.pressed.connect(_on_drawer_button_pressed.bind(13))
	$IngredientDrawer/Button14.pressed.connect(_on_drawer_button_pressed.bind(14))
	$IngredientDrawer/Button15.pressed.connect(_on_drawer_button_pressed.bind(15))
	$IngredientDrawer/Button16.pressed.connect(_on_drawer_button_pressed.bind(16))
	
func __init__(_allIngredients : Dictionary) -> void:
	# Set global dictionaries
	allIngredients = _allIngredients
	
func _on_drawer_button_pressed(pressed : int) -> void:
	if(held == null):
		if(pressed == 1):
			instance = spawn_test.instantiate()
			add_child(instance)
			instance.set_texture(load(allIngredients.get(allIngredients.keys()[0]).sprite))  
			held = 1
		if(pressed == 2):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 3):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 4):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 5):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 6):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 7):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 8):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 9):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 10):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 11):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 12):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 13):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 14):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 15):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
		if(pressed == 16):
			instance = spawn_test.instantiate()
			add_child(instance)
			held = 1
	



	
	
	
#func inst(pos):
	
	#instance.position = pos
	

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
		
	var i = 0
	
	for ingred in allIngredients.keys():
		$IngredientDrawer.get_child(i).get_child(0).set_texture(load(allIngredients.get(ingred).sprite))
		i = i + 1

func _on_hovered(hovered: bool) -> void:
	$IngredientDrawer.material.set_shader_parameter("outline_thickness", 5.0 if hovered else 0.0)



	

func _on_drop_spot_pressed() -> void:
	if (held == 1):
		$fruitBowl.texture = instance.texture
		instance.queue_free()
		held = null
	
