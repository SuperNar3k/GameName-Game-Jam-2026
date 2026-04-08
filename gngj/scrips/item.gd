class_name Item
extends Node

#GLOBAL VARIABLES

#FOR BOTH
var unlocked = false

var itemName = ""
var description = ""
var sprite = ""
var amountOwned

#FOR INGREDIENTS
var value

#FOR POTIONS
var recipe
var cookLevelNeeded

#Initiatize
func __init__(
	_sprite: String,
	_itemName: String,
	_description: String,
	_recipe = [],
	_amountOwned = 0,
	_cookLevelNeeded = 0,
	_value = 0
):
	itemName = _itemName
	description = _description
	amountOwned = _amountOwned
	sprite = _sprite
	recipe = _recipe
	cookLevelNeeded = _cookLevelNeeded
	value = _value
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
