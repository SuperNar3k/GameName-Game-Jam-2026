extends Control

var spawn_test = preload("res://Scenes/Spawn_Test.tscn")
var allIngredients
var instance

@onready var continueButton : Button = $continueButton

@onready var shopOption1 : TextureButton = $allButtons/shopOption1
@onready var shopOption2 : TextureButton = $allButtons/shopOption2
@onready var shopOption3 : TextureButton = $allButtons/shopOption3
@onready var shopOption4 : TextureButton = $allButtons/shopOption4
@onready var shopOption5 : TextureButton = $allButtons/shopOption5
@onready var shopOption6 : TextureButton = $allButtons/shopOption6
@onready var shopOption7 : TextureButton = $allButtons/shopOption7
@onready var shopOption8 : TextureButton = $allButtons/shopOption8
@onready var shopOption9 : TextureButton = $allButtons/shopOption9
@onready var shopOption10 : TextureButton = $allButtons/shopOption10
@onready var shopOption11 : TextureButton = $allButtons/shopOption11
@onready var shopOption12 : TextureButton = $allButtons/shopOption12
@onready var shopOption13 : TextureButton = $allButtons/shopOption13
@onready var shopOption14 : TextureButton = $allButtons/shopOption14
@onready var shopOption15 : TextureButton = $allButtons/shopOption15
@onready var shopOption16 : TextureButton = $allButtons/shopOption16

signal newDay
signal buy(cost, item)

var currency
var redColor = Color(0.926, 0.0, 0.0, 1.0)
var blackColor = Color()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	continueButton.pressed.connect(_on_continueButton_pressed)
	
	shopOption1.mouse_entered.connect(_on_mouse_entered.bind(shopOption1, "air's brevity"))
	shopOption1.mouse_exited.connect(_on_mouse_exited.bind(shopOption1, "air's brevity"))
	shopOption1.pressed.connect(_on_buyIngredient.bind("air's brevity"))
	
	shopOption2.mouse_entered.connect(_on_mouse_entered.bind(shopOption2, "desert calm"))
	shopOption2.mouse_exited.connect(_on_mouse_exited.bind(shopOption2, "desert calm"))
	shopOption2.pressed.connect(_on_buyIngredient.bind("desert calm"))
	
	
	shopOption3.mouse_entered.connect(_on_mouse_entered.bind(shopOption3, "dried ocean"))
	shopOption3.mouse_exited.connect(_on_mouse_exited.bind(shopOption3, "dried ocean"))
	shopOption3.pressed.connect(_on_buyIngredient.bind("dried ocean"))
	
	
	shopOption4.mouse_entered.connect(_on_mouse_entered.bind(shopOption4, "ear of the sea"))
	shopOption4.mouse_exited.connect(_on_mouse_exited.bind(shopOption4, "ear of the sea"))
	shopOption4.pressed.connect(_on_buyIngredient.bind("ear of the sea"))
	
	
	shopOption5.mouse_entered.connect(_on_mouse_entered.bind(shopOption5, "gaia's teeth"))
	shopOption5.mouse_exited.connect(_on_mouse_exited.bind(shopOption5, "gaia's teeth"))
	shopOption5.pressed.connect(_on_buyIngredient.bind("gaia's teeth"))
	
	
	shopOption6.mouse_entered.connect(_on_mouse_entered.bind(shopOption6, "dragon's egg"))
	shopOption6.mouse_exited.connect(_on_mouse_exited.bind(shopOption6, "dragon's egg"))
	shopOption6.pressed.connect(_on_buyIngredient.bind("dragon's egg"))
	
	
	shopOption7.mouse_entered.connect(_on_mouse_entered.bind(shopOption7, "spring crystal"))
	shopOption7.mouse_exited.connect(_on_mouse_exited.bind(shopOption7, "spring crystal"))
	shopOption7.pressed.connect(_on_buyIngredient.bind("spring crystal"))
	
	
	shopOption8.mouse_entered.connect(_on_mouse_entered.bind(shopOption8, "string of lovers"))
	shopOption8.mouse_exited.connect(_on_mouse_exited.bind(shopOption8, "string of lovers"))
	shopOption8.pressed.connect(_on_buyIngredient.bind("string of lovers"))
	
	
	shopOption9.mouse_entered.connect(_on_mouse_entered.bind(shopOption9, "venus's eyelashes"))
	shopOption9.mouse_exited.connect(_on_mouse_exited.bind(shopOption9, "venus's eyelashes"))
	shopOption9.pressed.connect(_on_buyIngredient.bind("venus's eyelashes"))
	
	
	shopOption10.mouse_entered.connect(_on_mouse_entered.bind(shopOption10, "winter crystal"))
	shopOption10.mouse_exited.connect(_on_mouse_exited.bind(shopOption10, "winter crystal"))
	shopOption10.pressed.connect(_on_buyIngredient.bind("winter crystal"))
	
	
	shopOption11.mouse_entered.connect(_on_mouse_entered.bind(shopOption11, "psychic stone"))
	shopOption11.mouse_exited.connect(_on_mouse_exited.bind(shopOption11, "psychic stone"))
	shopOption11.pressed.connect(_on_buyIngredient.bind("psychic stone"))
	
	
	shopOption12.mouse_entered.connect(_on_mouse_entered.bind(shopOption12, "shattered sky"))
	shopOption12.mouse_exited.connect(_on_mouse_exited.bind(shopOption12, "shattered sky"))
	shopOption12.pressed.connect(_on_buyIngredient.bind("shattered sky"))
	
	
	shopOption13.mouse_entered.connect(_on_mouse_entered.bind(shopOption13, "shooting star"))
	shopOption13.mouse_exited.connect(_on_mouse_exited.bind(shopOption13, "shooting star"))
	shopOption13.pressed.connect(_on_buyIngredient.bind("shooting star"))
	
	
	shopOption14.mouse_entered.connect(_on_mouse_entered.bind(shopOption14, "leaf of a thousand leaves"))
	shopOption14.mouse_exited.connect(_on_mouse_exited.bind(shopOption14, "leaf of a thousand leaves"))
	shopOption14.pressed.connect(_on_buyIngredient.bind("leaf of a thousand leaves"))
	
	
	shopOption15.mouse_entered.connect(_on_mouse_entered.bind(shopOption15, "a thorny heart"))
	shopOption15.mouse_exited.connect(_on_mouse_exited.bind(shopOption15, "a thorny heart"))
	shopOption15.pressed.connect(_on_buyIngredient.bind("a thorny heart"))
	
	shopOption16.mouse_entered.connect(_on_mouse_entered.bind(shopOption16, "tears of trees"))
	shopOption16.mouse_exited.connect(_on_mouse_exited.bind(shopOption16, "tears of trees"))
	shopOption16.pressed.connect(_on_buyIngredient.bind("tears of trees"))
	
	$continueButton.mouse_entered.connect(_on_hovered.bind(true))
	$continueButton.mouse_exited.connect(_on_hovered.bind(false))
	
func __init__(_allIngredients):
	allIngredients = _allIngredients
func _on_continueButton_pressed() -> void:
	newDay.emit()

func _on_buyIngredient(ingredient : String):
	print("Player wants to buy "+ingredient)
	match ingredient: 
		"leaf of a thousand leaves":
			buy.emit(1, ingredient)
		"a thorny heart":
			buy.emit(1, ingredient)
		"tears of trees":
			buy.emit(1, ingredient)
		"air's brevity":
			buy.emit(2, ingredient)
		"desert calm":
			buy.emit(2, ingredient)
		"dried ocean":
			buy.emit(2, ingredient)
		"ear of the sea":
			buy.emit(2, ingredient)
		"gaia's teeth":
			buy.emit(2, ingredient)
		"dragon's egg":
			buy.emit(3, ingredient)
		"spring crystal":
			buy.emit(3, ingredient)
		"string of lovers":
			buy.emit(3, ingredient)
		"venus's eyelashes":
			buy.emit(3, ingredient)
		"winter crystal":
			buy.emit(3, ingredient)
		"psychic stone":
			buy.emit(4, ingredient)
		"shattered sky":
			buy.emit(5, ingredient)
		"shooting star":
			buy.emit(6, ingredient)
				
	checkIfTooBroke()
	print("player bought "+ingredient)

func _on_hovered(hovered):
	$continuebuttonimg.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)

func checkIfTooBroke():
	for button in $allButtons.get_children():
		var lable = button.get_child(0)
		if(int(lable.text) > currency):
			lable.set("theme_override_colors/font_color", redColor)
		else:
			lable.set("theme_override_colors/font_color", blackColor)

func _on_mouse_entered(button: Variant, ingred_name):
	var ingred = allIngredients.get(ingred_name)
	instance = spawn_test.instantiate()
	add_child(instance)
	instance.get_child(0).text = (ingred.itemName + "\nOwned: " + str(ingred.amountOwned))
	button.material.set_shader_parameter("outline_thickness", 5.0)


func _on_mouse_exited(button: Variant, ingred_name):
	if instance != null:
		instance.queue_free()
	button.material.set_shader_parameter("outline_thickness", 0.0)
