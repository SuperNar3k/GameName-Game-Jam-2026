class_name Item_Factory
extends Node

#GLOBAL VARIABLES
var allIngredients = {}
var allPotions = {}

#Function explicitly for creating new ingredients
func createIngredient(
	_itemName: String,
	_description: String,
	_amountOwned: int,
	_sprite: String,
	_value: int
):
	var brandNewPart = Item.new()
	brandNewPart.__init__(
		_sprite,
		_itemName,
		_description,
		"",
		_amountOwned,
		0,
		_value
	)
	
	allIngredients.set(_itemName, brandNewPart)
	return brandNewPart
	
#Function used to create game potions. Will be overloaded to create dud potions.
func createPotion(
	_itemName: String,
	_description: String,
	_amountOwned: int,
	_sprite: String,
	_recipe: Array,
	_cookLevelNeeded: int
):
	var brandNewPart = Item.new()
	brandNewPart.__init__(
		_sprite,
		_itemName,
		_description,
		_recipe,
		_amountOwned,
		_cookLevelNeeded,
		0
	)
	
	allPotions.set(_itemName, brandNewPart)
	return brandNewPart

# Create the arrays
func Populate():
		
	#Hardcoding all of our Ingredients here
		#itemName
		#description
		#amountOwned
		#sprite
		#value
	
	createIngredient(
		"asbestos",									#ItemName
		"this shit will kill you",						#Description
		1000,											#AmountOwned
		"res://assets/ingredients/asbestos.png",		#Sprite
		3												#Value
	)
	
	createIngredient(
		"crushed asbestos",
		"this shit will kill you, also its a powder now",
		0,
		"res://assets/ingredients/crushed asbestos.jpg",
		0
	)
	
	createIngredient(
		"beans",
		"staight up beans nigga",
		3,
		"res://assets/ingredients/beans.png",
		3
	)
	
	#Hardcoding all of our Potions here
		#itemName
		#description
		#amountOwned
		#sprite
		#recipe
		#cookLevelNeeded
	
	createPotion(
		"cinnamon toast crunch milk",			#ItemName
		"this shit yummy af",					#Description
		0,										#AmountOwned
		"res://assets/potions/CTCBox.jpg",		#Sprite
		[0,1],									#Recipe
		0										#CookLevelNeeded
	)
	
	createPotion(
		"test name 3",
		"test desc 3",
		0,
		"res://assets/potions/three.jpg",
		[0,1,2],
		0
	)
	
	createPotion(
		"epic fucking monkey",
		"curious af",
		0,
		"res://assets/potions/funny_monkey.jpg",
		[1,1,2],
		0
	)
	
	createPotion(
		"test name 4",
		"test desc 4",
		0,
		"res://assets/potions/four.jpg",
		[0,2,2],
		0
	)
	
	createPotion(
		"test name 6",
		"test desc 6",
		0,
		"res://assets/potions/six.jpg",
		[2,2,2],
		0
	)
	
	createPotion(
		"test name 5",
		"test desc 5",
		0,
		"res://assets/potions/five.jpg",
		[1,2,2],
		0
	)
	
	# DEBUG ONLY, REMOVE LATER
	print(allIngredients)
	print(allPotions)

# Unlocks default items at start of game
func UnlockDefaultIngredients(_unlockedIngredients: Dictionary):
	var newItem = allIngredients.get("beans") 
	newItem.unlocked = true
	_unlockedIngredients.set(newItem.itemName, newItem)
	
	newItem = allIngredients.get("asbestos") 
	newItem.unlocked = true
	_unlockedIngredients.set(newItem.itemName, newItem)
	
	newItem = allIngredients.get("crushed asbestos") 
	newItem.unlocked = true
	_unlockedIngredients.set(newItem.itemName, newItem)
	
func UnlockDefaultPotions(_unlockedPotions: Dictionary):
	var a = allPotions.get("cinnamon toast crunch milk") 
	a.unlocked = true
	_unlockedPotions.set(a.itemName, a)

# Unlock a new ingredient
func UnlockIngredient(_unlockedIngredients: Dictionary, _ingName: String):
	var ing = allIngredients.get(_ingName) 
	ing.unlocked = true
	_unlockedIngredients.set(_ingName, ing)

# Unlock a new potion
func UnlockPotion(_unlockedPotions: Array, _potName: String):
	var pot = allPotions.get(_potName) 
	pot.unlocked = true
	_unlockedPotions.append(pot)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
