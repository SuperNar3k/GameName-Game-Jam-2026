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
		#grindable
	#
	#createIngredient(
	#	"asbestos",										#ItemName
	#	"this shit will kill you",						#Description
	#	0,											#AmountOwned
	#	"res://assets/ingredients/asbestos.png",		#Sprite
	#	3,												#Value
	#	true											#grindable
	#)
	
	#createIngredient(
		#"crushed asbestos",
		#"this shit will kill you, also its a powder now",
		#0,
		#"res://assets/ingredients/crushed asbestos.jpg",
		#0,
		#false
	#)
	
	createIngredient("earth", "dirt", 69, "res://assets/ingredients/earth.PNG", 0, false)
	createIngredient("a leaf of a thousand leaves", "fern", 0, "res://assets/ingredients/a leaf of a thousand leaves.PNG", 1, true)
	createIngredient("a leaf of a thousand leaves powder", "crushed fern", 0, "res://assets/ingredients/a leaf of a thousand leaves powder.PNG", 1, false)
	createIngredient("a thorny heart", "cactus", 0, "res://assets/ingredients/a thorny heart.PNG", 1, true)
	createIngredient("a thorny heart powder", "crushed cactus", 0, "res://assets/ingredients/a thorny heart powder.PNG", 1, false)
	createIngredient("tears of trees", "string of pearls", 4, "res://assets/ingredients/tears of trees.PNG", 1, true)
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
	createIngredient("spring crystal", "pink crystal", 0, "res://assets/ingredients/spring crystal.PNG", 3, true)
	createIngredient("spring crystal powder", "crushed pink crystal", 0, "res://assets/ingredients/spring crystal powder.PNG", 3, false)
	createIngredient("string of lovers", "bleeding hearts", 0, "res://assets/ingredients/string of lovers.PNG", 3, true)
	createIngredient("string of lovers powder", "crushed bleeding hearts", 0, "res://assets/ingredients/string of lovers powder.PNG", 3, false)
	createIngredient("venus's eyelashes", "venus flytrap", 0, "res://assets/ingredients/venus's eyelashes.PNG", 3, true)
	createIngredient("venus's eyelashes powder", "crushed venus flytrap", 0, "res://assets/ingredients/venus's eyelashes powder.PNG", 3, false)
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
		"epic fucking monkey",
		"curious af",
		3,
		"res://assets/potions/funny_monkey.jpg",
		["crushed asbestos","crushed asbestos","beans"],
		0
	)
	createPotion(
		"another test",
		"abcd",
		0,
		"res://assets/potions/five.jpg",
		["earth","tears of trees","earth"],
		0
	)
	
	createPotion(
		"Animal Shape Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Animal Shape Potion.PNG",				#Sprite
		["dragon's egg","earth","venus's eyelashes"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Beuty Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Beauty Potion.PNG",				#Sprite
		["ear of the sea powder","string of lovers powder","venus's eyelashes"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Charm Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Charm Potion.PNG",				#Sprite
		["a thorny heart", "string of lovers", "venus's eyelashes"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Clairvoyance Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Clairvoiancy Potion.PNG",				#Sprite
		["air's brevity", "ear of the sea", "psychic stone powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Cold Resistance Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Cold Resist Potion.PNG",				#Sprite
		["dragon's egg powder", "gaia's teeth powder", "winter crystal powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Courage Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Courage Potion.PNG",				#Sprite
		["a thorny heart", "gaia's teeth", "psychic stone"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Cure All Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Cure All Potion.PNG",				#Sprite
		["gaia's teeth", "leaf of a thousand leaves", "stardust"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Darkness Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Darkness Potion.PNG",				#Sprite
		["leaf of a thousand leaves powder", "tears of trees", "shattered sky"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Demon Conjuration Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Demon Conjuration Potion.PNG",				#Sprite
		["a thorny heart", "desert calm powder", "earth"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Dragon's Breath Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Dragon's Breath Potion.PNG",				#Sprite
		["a thorny heart", "air's brevity", "dragon's egg powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"False Death Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/False Death Potion.PNG",				#Sprite
		["earth", "leaf of a thousand leaves powder", "winter crystal powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Fire Resistance Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Fire Resistance Potion.PNG",				#Sprite
		["a thorny heart powder", "desert calm", "dried ocean"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Flying Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Flying Potion.PNG",				#Sprite
		["air's brevity", "dragon's egg powder", "stardust"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Fog in a Bottle",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Fog in a bottle.PNG",				#Sprite
		["a thorny heart", "dried ocean", "shattered sky"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Friendship Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Friendship Potion.PNG",				#Sprite
		["desert calm", "psychic stone powder", "spring crystal powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Growth Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Growth Potion.PNG",				#Sprite
		["earth", "gaia's teeth powder", "spring crystal"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Healing Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Healing Potion.PNG",				#Sprite
		["desert calm", "earth", "string of lovers"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Heat Resistance Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Heat Resistance Potion.PNG",				#Sprite
		["a thorny heart", "earth", "tears of trees"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Invincibility Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Invincibility Potion.PNG",				#Sprite
		["gaia's teeth", "shattered sky", "stardust"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Invisibility Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Invisibility Potion.PNG",				#Sprite
		["air's brevity", "dried ocean", "winter crystal"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Love Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Love Potion.PNG",				#Sprite
		["psychic stone powder", "string of lovers powder", "venus's eyelashes powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Luck Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Luck Potion.PNG",				#Sprite
		["air's brevity", "psychic stone powder", "shooting star"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Mind Reading Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Mind Reading Potion.PNG",				#Sprite
		["ear of the sea", "psychic stone powder", "psychic stone"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Ooze Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Ooze Potion.PNG",				#Sprite
		["desert calm", "spring crystal powder", "tears of trees powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Petrification Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Petrification Potion.PNG",				#Sprite
		["a thorny heart powder", "gaia's teeth powder", "winter crystal"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Randomization Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Randomization Potion.PNG",				#Sprite
		["air's brevity", "earth", "spring crystal powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Relaxation Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Relaxation Potion.PNG",				#Sprite
		["desert calm", "dried ocean", "ear of the sea powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Sill Perfection Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Skill PerfectionPotion.PNG",				#Sprite
		["gaia's teeth", "leaf of a thousand leaves powder", "psychic stone"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Speak With Animals Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Speak With Animals Potion.PNG",				#Sprite
		["desert calm", "earth", "tears of trees"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Stone Skin Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Stone Skin Potion.PNG",				#Sprite
		["dragon's egg","dried ocean", "gaia's teeth"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Storm In A Bottle",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Storm In a Bottle.PNG",				#Sprite
		["air's brevity", "dragon's egg powder", "ear of the sea powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Strength Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Strength Potion.PNG",				#Sprite
		["dragon's egg powder", "gaia's teeth", "tears of trees powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Time In A Bottle",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Time In a Bottle.PNG",				#Sprite
		["shattered sky", "spring crystal powder", "winter crystal powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Toxic Resistance Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Toxic Resist Potion.PNG",				#Sprite
		["a thorny heart powder", "desert calm powder", "ear of the sea powder"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Water Breathing Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Water Breathing Potion.PNG",				#Sprite
		["air's brevity", "dried ocean", "ear of the sea"],							#Recipe
		0															#CookLevelNeeded
	)
	
	createPotion(
		"Water Walking Potion",										#ItemName
		"I'll do it later, you'll just have to give me a second",		#Description
		0,															#AmountOwned
		"res://assets/potions/Water Walking Potion.PNG",				#Sprite
		["air's brevity", "dried ocean", "winter crystal"],							#Recipe
		0															#CookLevelNeeded
	)
	
	# DEBUG ONLY, REMOVE LATER
	print(allIngredients)
	print(allPotions)

# Unlocks default items at start of game
func UnlockDefaultIngredients(_unlockedIngredients: Dictionary):
	var newItem = allIngredients.get("earth")
	newItem.unlocked = true
	_unlockedIngredients.set(newItem.itemName, newItem)
	
	newItem = allIngredients.get("tears of trees")
	newItem.unlocked = true
	_unlockedIngredients.set(newItem.itemName, newItem)
	
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
func UnlockPotion(_unlockedPotions: Dictionary, _potName: String, ing):
	var pot = allPotions.get(_potName) 
	if pot == null:
		var potion = createPotion(
			_potName,
			"This potion does nothing but taste bad",
			1,
			"res://assets/potions/CTCBox.jpg",
			ing,
			0
			)
		allPotions.set(_potName, potion)
		pot = allPotions.get(_potName) 
	pot.unlocked = true
	_unlockedPotions.set(_potName, pot)
	

	
