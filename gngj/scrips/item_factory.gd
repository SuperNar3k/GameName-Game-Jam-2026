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
	_value: int,
	_isGrindable: bool

):
	var brandNewPart = Item.new()
	brandNewPart.__init__(
		_sprite,
		_itemName,
		_description,
		[],
		_amountOwned,
		0,
		_value,
		_isGrindable
	)
	
	allIngredients.set(_itemName, brandNewPart)
	return brandNewPart
	
#Function used to create game potions. Will be overloaded to create dud potions.
func createPotion(
	_itemName: String,
	_description: String,
	_amountOwned: int,
	_sprite: String,
	_recipe: Array[String],
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
		#grindable
	#
	createIngredient(
		"asbestos",										#ItemName
		"this shit will kill you",						#Description
		1000,											#AmountOwned
		"res://assets/ingredients/asbestos.png",		#Sprite
		3,												#Value
		true											#grindable
	)
	
	createIngredient(
		"crushed asbestos",
		"this shit will kill you, also its a powder now",
		0,
		"res://assets/ingredients/crushed asbestos.jpg",
		0,
		false
	)
	#
	createIngredient(
		"beans",
		"staight up beans nigga",
		3,
		"res://assets/ingredients/beans.png",
		3,
		true
	)
	createIngredient("earth", "dirt", 0, "res://assets/ingredients/earth.PNG", 0, false)
	createIngredient("a leaf of a thousand leaves", "fern", 0, "res://assets/ingredients/a leaf of a thousand leaves.PNG", 1, true)
	createIngredient("a leaf of a thousand leaves powder", "crushed fern", 0, "res://assets/ingredients/a leaf of a thousand leaves powder.PNG", 1, false)
	createIngredient("a thorny heart", "cactus", 0, "res://assets/ingredients/a thorny heart.PNG", 1, true)
	createIngredient("a thorny heart powder", "crushed cactus", 0, "res://assets/ingredients/a thorny heart powder.PNG", 1, false)
	createIngredient("tears of trees", "string of pearls", 0, "res://assets/ingredients/tears of trees.PNG", 1, true)
	createIngredient("tears of trees powder", "crushed string of pearls", 0, "res://assets/ingredients/tears of trees powder.PNG", 1, false)
	createIngredient("air's brevity", "feather", 0, "res://assets/ingredients/air's brevity.PNG", 2, false)
	createIngredient("desert calm", "aloe", 0, "res://assets/ingredients/desert calm.PNG", 2, true)
	createIngredient("desert calm powder", "crushed aloe", 0, "res://assets/ingredients/desert calm powder.PNG", 2, false)
	createIngredient("dried ocean", "sand", 0, "res://assets/ingredients/dried ocean.PNG", 2, false)
	createIngredient("ear of the sea", "conch shells", 0, "res://assets/ingredients/ear of the sea.PNG", 2, true)
	createIngredient("ear of the sea powder", "crushed conch shells", 0, "res://assets/ingredients/ear of the sea powder.PNG", 2, false)
	createIngredient("gaia's teeth", "pebbles", 0, "res://assets/ingredients/gaia's teeth.PNG", 2, true)
	createIngredient("gaia's teeth powder", "crushed pebbles", 0, "res://assets/ingredients/gaia's teeth powder.PNG", 2, false)
	createIngredient("dragon's egg", "dragon fruit", 0, "res://assets/ingredients/dragon's egg.PNG", 3, true)
	createIngredient("dragon's egg powder", "crushed dragon fruit", 0, "res://assets/ingredients/dragon's egg powder.PNG", 3, false)
	createIngredient("venus's eyelashes powder", "crushed venus flytrap", 0, "res://assets/ingredients/venus's eyelashes powder.PNG", 3, false)
	createIngredient("spring crystal", "pink crystal", 0, "res://assets/ingredients/spring crystal.PNG", 3, true)
	createIngredient("spring crystal powder", "crushed pink crystal", 0, "res://assets/ingredients/spring crystal powder.PNG", 3, false)
	createIngredient("string of lovers", "bleeding hearts", 0, "res://assets/ingredients/string of lovers.PNG", 3, true)
	createIngredient("string of lovers powder", "crushed bleeding hearts", 0, "res://assets/ingredients/string of lovers powder.PNG", 3, false)
	createIngredient("venus's eyelashes", "venus flytrap", 0, "res://assets/ingredients/venus's eyelashes.PNG", 3, true)
	createIngredient("winter crystal", "blue crystal", 0, "res://assets/ingredients/winter crystal.PNG", 3, true)
	createIngredient("winter crystal powder", "crushed blue crystal", 0, "res://assets/ingredients/winter crystal powder.PNG", 3, false)
	createIngredient("psychic stone", "amethyst", 0, "res://assets/ingredients/psychic stone.PNG", 4, true)
	createIngredient("psychic stone powder", "crushed amethyst", 0, "res://assets/ingredients/psychic stone powder.PNG", 4, false)
	createIngredient("shattered sky", "obsidian", 0, "res://assets/ingredients/shattered sky.PNG", 5, false)
	createIngredient("shooting star", "star", 0, "res://assets/ingredients/shooting star.PNG", 6, true)
	createIngredient("stardust", "stardust", 0, "res://assets/ingredients/stardust.PNG", 6, false)

	
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
		69,										#AmountOwned
		"res://assets/potions/CTCBox.jpg",		#Sprite
		["asbestos", "crushed asbestos"],		#Recipe
		0										#CookLevelNeeded
	)
	
	createPotion(
		"dud",									#ItemName
		"a failed experiment",					#Description
		0,										#AmountOwned
		"res://assets/npcs/lil freak.jpg",		#Sprite
		[],										#Recipe
		0										#CookLevelNeeded
	)
	
	createPotion(
		"test name 3",
		"test desc 3",
		0,
		"res://assets/potions/three.jpg",
		["asbestos","crushed asbestos","beans"],
		0
	)
	
	createPotion(
		"epic fucking monkey",
		"curious af",
		3,
		"res://assets/potions/funny_monkey.jpg",
		["crushed asbestos","crushed asbestos","beans"],
		0
	)
	
	createPotion(
		"test name 4",
		"test desc 4",
		0,
		"res://assets/potions/four.jpg",
		["asbestos","beans","beans"],
		0
	)
	
	createPotion(
		"test name 6",
		"test desc 6",
		0,
		"res://assets/potions/six.jpg",
		["beans","beans","beans"],
		0
	)
	
	createPotion(
		"test name 5",
		"test desc 5",
		0,
		"res://assets/potions/five.jpg",
		["crushed asbestos","beans","beans"],
		0
	)
	
	createPotion(
		"test name 7",
		"test desc 7",
		0,
		"res://assets/potions/five.jpg",
		["crushed asbestos"],
		0
	)
	
	createPotion(
		"za heroin",
		"zzzzzzzzzz",
		0,
		"res://assets/potions/five.jpg",
		["beans","beans","beans","beans","beans"],
		0
	)
	

# Unlocks default items at start of game
func UnlockDefaultIngredients(_unlockedIngredients: Dictionary):
	#var newItem = allIngredients.get("beans") 
	#newItem.unlocked = true
	#_unlockedIngredients.set(newItem.itemName, newItem)
	#
	#newItem = allIngredients.get("asbestos") 
	#newItem.unlocked = true
	#_unlockedIngredients.set(newItem.itemName, newItem)
	#
	#newItem = allIngredients.get("crushed asbestos") 
	#newItem.unlocked = true
	#_unlockedIngredients.set(newItem.itemName, newItem)
	pass
	
func UnlockDefaultPotions(_unlockedPotions: Dictionary):
	var a = allPotions.get("cinnamon toast crunch milk") 
	a.unlocked = true
	_unlockedPotions.set(a.itemName, a)
	
	a = allPotions.get("za heroin") 
	a.unlocked = true
	_unlockedPotions.set(a.itemName, a)

# Unlock a new ingredient
func UnlockIngredient(_unlockedIngredients: Dictionary, _ingName: String):
	var ing = allIngredients.get(_ingName) 
	ing.unlocked = true
	_unlockedIngredients.set(_ingName, ing)

# Unlock a new potion
func UnlockPotion(_unlockedPotions: Dictionary, _potName: String):
	var pot = allPotions.get(_potName) 
	pot.unlocked = true
	_unlockedPotions.set(_potName, pot)
	

	
