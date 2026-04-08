extends Control

@onready var continueButton : Button = $continueButton

@onready var item1 : Button = $allButtons/shopOption1
@onready var item2 : Button = $allButtons/shopOption2


signal newDay
signal buy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	continueButton.pressed.connect(_on_continueButton_pressed)
	item1.pressed.connect(_on_buyIngredient.bind("beans"))
	item2.pressed.connect(_on_buyIngredient.bind("aspestos"))
	
func _on_continueButton_pressed() -> void:
	newDay.emit()

func _on_buyIngredient(ingredient : String):
	match ingredient: 
		"beans":
			buy.emit(2,int($allButtons/shopOption1/optionCost.text))
		"aspestos":
			buy.emit(0,int($allButtons/shopOption2/optionCost.text))
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
