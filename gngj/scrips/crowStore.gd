extends Control

@onready var continueButton : Button = $continueButton




signal newDay
signal buy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	continueButton.pressed.connect(_on_continueButton_pressed)

	
func _on_continueButton_pressed() -> void:
	newDay.emit()

func _on_buyIngredient(ingredient : String):
	match ingredient: 
		"beans":
			buy.emit(2,int($allButtons/shopOption1/optionCost.text))
		"aspestos":
			buy.emit(0,int($allButtons/shopOption2/optionCost.text))
			
