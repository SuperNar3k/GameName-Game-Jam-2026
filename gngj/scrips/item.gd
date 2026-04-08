class_name Item
extends Node

#GLOBAL VARIABLES
#FOR BOTH
var itemName = ""
var description = ""
var amountOwned = 0
var unlocked = false
var sprite = ""
#FOR INGREDIENTS
var value
#FOR POTIONS
var recipe = []
var cookLevelNeeded = 0

#Function explicitly for creating new Ingredients
func createIngredient(
	_itemName: Variant,
	_description: Variant,
	_amountOwned: Variant,
	_sprite: Variant,
	_value: Variant
):
	itemName = _itemName
	description = _description
	amountOwned = _amountOwned
	unlocked = false
	sprite = _sprite
	value = _value
	
#Function used to create game potions. Will be overloaded to create dud potions.
func createPotion(
	_itemName: Variant,
	_description: Variant,
	_amountOwned: Variant,
	_sprite: Variant,
	_recipe: Variant,
	_cookLevelNeeded: Variant
):
	itemName = _itemName
	description = _description
	amountOwned = _amountOwned
	sprite = _sprite
	recipe = _recipe
	cookLevelNeeded = _cookLevelNeeded
	





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
