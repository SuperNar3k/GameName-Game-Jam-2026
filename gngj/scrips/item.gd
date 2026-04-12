class_name Item
extends Node

#GLOBAL VARIABLES

#FOR BOTH
var unlocked = false

var itemName = ""
var description = ""
var sprite = ""
var amountOwned : int

#FOR INGREDIENTS
var value : int
var isGrindable : bool

#FOR POTIONS
var recipe : Array
var cookLevelNeeded : int

#Initiatize
func __init__(
	_sprite: String,
	_itemName: String,
	_description: String,
	_recipe = [],
	_amountOwned = 0,
	_cookLevelNeeded = 0,
	_value = 0,
	_isGrindable = false

):
	itemName = _itemName
	description = _description
	amountOwned = _amountOwned
	sprite = _sprite
	recipe = _recipe
	cookLevelNeeded = _cookLevelNeeded
	value = _value
	isGrindable = _isGrindable
	
