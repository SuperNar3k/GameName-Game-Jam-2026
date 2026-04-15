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
		0,
		[],
		_amountOwned,
		0,
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
	_cookLevelNeeded: int,
	_value: int
):
	var brandNewPart = Item.new()
	brandNewPart.__init__(
		_sprite,
		_itemName,
		_description,
		_value,
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
	
	createIngredient("earth", "dirt", 9999, "res://assets/ingredients/earth.PNG", 0, false)
	createIngredient("leaf of a thousand leaves", "fern", 0, "res://assets/ingredients/a leaf of a thousand leaves.PNG", 1, true)
	createIngredient("leaf of a thousand leaves powder", "crushed fern", 0, "res://assets/ingredients/a leaf of a thousand leaves powder.PNG", 1, false)
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
	
	createPotion(
		"Animal Shape Potion",										#ItemName
		"Often used by non-magic folk to be able to shift their forms to resemble an animal of their choosing. Think carefully as you drink.",		#Description
		0,															#AmountOwned
		"res://assets/potions/Animal Shape Potion.PNG",				#Sprite
		["dragon's egg","earth","venus's eyelashes"],							#Recipe
		0,
		8															#CookLevelNeeded
	)
	
	createPotion(
		"Beauty Potion",										#ItemName
		"A glamor potion to beautify one's appearance temporarily. It is said the Crown Prince has banned this potion in the castle to prevent anyone from appearing more handsome than he.",		#Description
		0,															#AmountOwned
		"res://assets/potions/Beauty Potion.PNG",				#Sprite
		["ear of the sea powder","string of lovers powder","venus's eyelashes"],							#Recipe
		0,
		12															#CookLevelNeeded
	)
	
	createPotion(
		"Charm Potion",										#ItemName
		"Grants the drinker charm and charisma only irresistible by the shrewdest of targets.",		#Description
		0,															#AmountOwned
		"res://assets/potions/Charm Potion.PNG",				#Sprite
		["a thorny heart", "string of lovers", "venus's eyelashes"],							#Recipe
		0,
		9															#CookLevelNeeded
	)
	
	createPotion(
		"Clairvoyance Potion",										#ItemName
		"Provides mild clairvoyance effects and seeing shortly into the future. Most useful for dodging strikes in battle and questions by in-laws. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Clairvoiancy Potion.PNG",				#Sprite
		["air's brevity", "ear of the sea", "psychic stone powder"],							#Recipe
		0,
		11															#CookLevelNeeded
	)
	
	createPotion(
		"Cold Resistance Potion",										#ItemName
		"A potion useful for adventurers voyaging great peaks and traveling to the deepest of freezing tundras. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Cold Resist Potion.PNG",				#Sprite
		["dragon's egg powder", "gaia's teeth powder", "winter crystal powder"],							#Recipe
		0,
		13															#CookLevelNeeded
	)
	
	createPotion(
		"Courage Potion",										#ItemName
		"An elixir that strengthens the drinkers courage and raises one's spirits",		#Description
		0,															#AmountOwned
		"res://assets/potions/Courage Potion.PNG",				#Sprite
		["a thorny heart", "gaia's teeth", "psychic stone"],							#Recipe
		0,
		9															#CookLevelNeeded
	)
	
	createPotion(
		"Cure All Potion",										#ItemName
		"An antidote to almost all known ailments. A useful potion for anyone to have on hand, not just for adventurers setting off into the unknown.",		#Description
		0,															#AmountOwned
		"res://assets/potions/Cure All Potion.PNG",				#Sprite
		["gaia's teeth", "leaf of a thousand leaves", "stardust"],							#Recipe
		0,
		12															#CookLevelNeeded
	)
	
	createPotion(
		"Darkness Potion",										#ItemName
		"Non-drinkable concoction intended to create a field of darkness where its contents are splashed. The more powerful the potion maker, the more powerful the darkness that creeps in. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Darkness Potion.PNG",				#Sprite
		["leaf of a thousand leaves powder", "tears of trees", "shattered sky"],							#Recipe
		0,
		10															#CookLevelNeeded
	)
	
	createPotion(
		"Demon Conjuration Potion",										#ItemName
		"A concoction that opens the heart of the drinker to demonic possession. Useful for those who are ambitious to make deals with devils or for cursing your enemies. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Demon Conjuration Potion.PNG",				#Sprite
		["a thorny heart", "desert calm powder", "earth"],							#Recipe
		0,
		15															#CookLevelNeeded
	)
	
	createPotion(
		"Dragon's Breath Potion",										#ItemName
		"Grants the drinker the ability to safely exhale tremendous flames. The larger the intake, the larger the blaze. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Dragon's Breath Potion.PNG",				#Sprite
		["a thorny heart", "air's brevity", "dragon's egg powder"],							#Recipe
		0,
		9															#CookLevelNeeded
	)
	
	createPotion(
		"False Death Potion",										#ItemName
		"Provides the drinker a believable death. The drinker's heart rate slows to be nearly imperceptible. The drinker pales and is immobile for the duration of the potion's effect. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/False Death Potion.PNG",				#Sprite
		["earth", "leaf of a thousand leaves powder", "winter crystal powder"],							#Recipe
		0,
		15															#CookLevelNeeded
	)
	
	createPotion(
		"Fire Resistance Potion",										#ItemName
		"An elixir that allows the drinker to penetrate and survive the hottest of fires. Resist calamity, dragons, and blacksmithing mishaps. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Fire Resistance Potion.PNG",				#Sprite
		["a thorny heart powder", "desert calm", "dried ocean"],							#Recipe
		0,
		10															#CookLevelNeeded
	)
	
	createPotion(
		"Flying Potion",										#ItemName
		"This potion grants flight, until it wears off. In which case, it grants falling. Use with caution. Do not fly too high without proper precautions and training. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Flying Potion.PNG",				#Sprite
		["air's brevity", "dragon's egg powder", "stardust"],							#Recipe
		0,
		15															#CookLevelNeeded
	)
	
	createPotion(
		"Fog in a Bottle",										#ItemName
		"Bottled mist and fog to provide coverage in battle. Or for dramatic flair. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Fog in a bottle.PNG",				#Sprite
		["a thorny heart", "dried ocean", "shattered sky"],							#Recipe
		0,
		10															#CookLevelNeeded
	)
	
	createPotion(
		"Friendship Potion",										#ItemName
		"The drinker shares the bottle between themselves and their to-friend. The potion increases friendliness between drinkers to allow for true friendship. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Friendship Potion.PNG",				#Sprite
		["desert calm", "psychic stone powder", "spring crystal powder"],							#Recipe
		0,
		9															#CookLevelNeeded
	)
	
	createPotion(
		"Growth Potion",										#ItemName
		"Excellent elixir for urgent growing and reviving crops. Sometimes used by kids and bodybuilders to temporarily boost their strength and body size. Only temporary in humanoid creatures. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Growth Potion.PNG",				#Sprite
		["earth", "gaia's teeth powder", "spring crystal"],							#Recipe
		0,
		8															#CookLevelNeeded
	)
	
	createPotion(
		"Healing Potion",										#ItemName
		"Useful in a tight pinch to quickly recover vitality and restore one's self from bruises, scrapes, and breaks. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Healing Potion.PNG",				#Sprite
		["desert calm", "earth", "string of lovers"],							#Recipe
		0,
		7															#CookLevelNeeded
	)
	
	createPotion(
		"Heat Resistance Potion",										#ItemName
		"Grants the user the ability to brave the hottest of terrains without breaking a sweat. Great potion for beginners to try out. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Heat Resistance Potion.PNG",				#Sprite
		["a thorny heart", "earth", "tears of trees"],							#Recipe
		0,
		5															#CookLevelNeeded
	)
	
	createPotion(
		"Invincibility Potion",										#ItemName
		"The coveted and rare invincibility potion grants the drinker ultimate invincibility to obstacles and enemies. Provides supernatural strength and clarity, it is sometimes referred to as the Deity Drink. The Royal family is offering a great reward to the skilled craftsman that can recreate this potion. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Invincibility Potion.PNG",				#Sprite
		["gaia's teeth", "shattered sky", "stardust"],							#Recipe
		0,
		100															#CookLevelNeeded
	)
	
	createPotion(
		"Invisibility Potion",										#ItemName
		"Temporarily makes the drinker invisible and imperceptible to the unaided eye. Alternatively, useful for splash on objects that you need to hide quickly. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Invisibility Potion.PNG",				#Sprite
		["air's brevity", "dried ocean", "winter crystal"],							#Recipe
		0,
		9															#CookLevelNeeded
	)
	
	createPotion(
		"Love Potion",										#ItemName
		"Shared among two would-be lovers to create a feeling of infatuation between the two. Eventually wears off, but impairs both users in interaction to respond as if madly in love. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Love Potion.PNG",				#Sprite
		["psychic stone powder", "string of lovers powder", "venus's eyelashes powder"],							#Recipe
		0,
		15															#CookLevelNeeded
	)
	
	createPotion(
		"Luck Potion",										#ItemName
		"Grants the drinker brief, but extreme sway over Lady Luck. Luck potion blood levels checked before entering casinos and horse tracks. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Luck Potion.PNG",				#Sprite
		["air's brevity", "psychic stone powder", "shooting star"],							#Recipe
		0,
		15															#CookLevelNeeded
	)
	
	createPotion(
		"Mind Reading Potion",										#ItemName
		"Low level mind reading potion that allows the drinker to focus on a target and comprehend their thoughts. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Mind Reading Potion.PNG",				#Sprite
		["ear of the sea", "psychic stone powder", "psychic stone"],							#Recipe
		0,
		13															#CookLevelNeeded
	)
	
	createPotion(
		"Ooze Potion",										#ItemName
		"Bottled ooze creation. Temporarily acts as an ooze monster that slows and dissipates over time. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Ooze Potion.PNG",				#Sprite
		["desert calm", "spring crystal powder", "tears of trees powder"],							#Recipe
		0,
		10															#CookLevelNeeded
	)
	
	createPotion(
		"Petrification Potion",										#ItemName
		"Tinctures that turns the drinker into a petrified statue. Permanent effects until cured. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Petrification Potion.PNG",				#Sprite
		["a thorny heart powder", "gaia's teeth powder", "winter crystal"],							#Recipe
		0,
		10															#CookLevelNeeded
	)
	
	createPotion(
		"Randomization Potion",										#ItemName
		"A mysterious potion that has ultimately unknown effects. While having a known recipe, it appears to Lady Luck's play thing and throws a different effect at the user like a roulette. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Randomization Potion.PNG",				#Sprite
		["air's brevity", "earth", "spring crystal powder"],							#Recipe
		0,
		10															#CookLevelNeeded
	)
	
	createPotion(
		"Relaxation Potion",										#ItemName
		"A peaceful potion that calms the drinker and provides mental clarity and eases the nerves. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Relaxation Potion.PNG",				#Sprite
		["desert calm", "dried ocean", "ear of the sea powder"],							#Recipe
		0,
		9															#CookLevelNeeded
	)
	
	createPotion(
		"Skill Perfection Potion",										#ItemName
		"Allows the user to temporarily master a skill. often used for impressing one's date with an excellently cooked meal.",		#Description
		0,															#AmountOwned
		"res://assets/potions/Skill Perfection Potion.PNG",				#Sprite
		["gaia's teeth", "leaf of a thousand leaves powder", "psychic stone"],							#Recipe
		0,
		10															#CookLevelNeeded
	)
	
	createPotion(
		"Speak With Animals Potion",										#ItemName
		"Permits the drinker to understand animal speak. Temporary effects. Be wary of what the squirrels may know about you. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Speak With Animals Potion.PNG",				#Sprite
		["desert calm", "earth", "tears of trees"],							#Recipe
		0,
		5															#CookLevelNeeded
	)
	
	createPotion(
		"Stone Skin Potion",										#ItemName
		"Creates an impenetrable upper skin layer as strong as stone. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Stone Skin Potion.PNG",				#Sprite
		["dragon's egg","dried ocean", "gaia's teeth"],							#Recipe
		0,
		9															#CookLevelNeeded
	)
	
	createPotion(
		"Storm In A Bottle",										#ItemName
		"A bottled torrential rainstorm that can be unleashed upon your enemies or just your neighbors who just planted a horrendously ugly tree by your bedroom window. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Storm In a Bottle.PNG",				#Sprite
		["air's brevity", "dragon's egg powder", "ear of the sea powder"],							#Recipe
		0,
		11															#CookLevelNeeded
	)
	
	createPotion(
		"Strength Potion",										#ItemName
		"A potion that fortifies the drinker and increases their constitution and strength. A must have in fights against magical creatures. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Strength Potion.PNG",				#Sprite
		["dragon's egg powder", "gaia's teeth", "tears of trees powder"],							#Recipe
		0,
		10															#CookLevelNeeded
	)
	
	createPotion(
		"Time In A Bottle",										#ItemName
		"The drinker rapidly ages and the effects of time hit them like a storm. Sometimes reversible, but often too difficult for most potion masters to handle.",		#Description
		0,															#AmountOwned
		"res://assets/potions/Time In a Bottle.PNG",				#Sprite
		["shattered sky", "spring crystal powder", "winter crystal powder"],							#Recipe
		0,
		15															#CookLevelNeeded
	)
	
	createPotion(
		"Toxic Resistance Potion",										#ItemName
		"Allows the drinker to resist toxic conditions and hazardous slimes. Useful against the toxins lurking in the Darkwoods Swamp and the Strong Sea's deep water dwellers. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Toxic Resist Potion.PNG",				#Sprite
		["a thorny heart powder", "desert calm powder", "ear of the sea powder"],							#Recipe
		0,
		10															#CookLevelNeeded
	)
	
	createPotion(
		"Water Breathing Potion",										#ItemName
		"Grants the drinker the ability to breathe underwater and handle the pressure of deep diving temporarily. Often used by Massive Clam divers who provide the kingdom's supply of pearls. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Water Breathing Potion.PNG",				#Sprite
		["air's brevity", "dried ocean", "ear of the sea"],							#Recipe
		0,
		8															#CookLevelNeeded
	)
	
	createPotion(
		"Water Walking Potion",										#ItemName
		"Grants safe passage to those who need to walk across distances of water or other inhospitable terrains. Allows the drinker to gently float above the ground. ",		#Description
		0,															#AmountOwned
		"res://assets/potions/Water Walking Potion.PNG",				#Sprite
		["air's brevity", "dried ocean", "winter crystal"],							#Recipe
		0,
		9															#CookLevelNeeded
	)

# Unlock a new ingredient
func UnlockIngredient(_unlockedIngredients: Dictionary, _ingName: String):
	var ing = allIngredients.get(_ingName) 
	ing.unlocked = true
	_unlockedIngredients.set(_ingName, ing)

# Unlock a new potion
func UnlockPotion(_unlockedPotions: Dictionary, _potName: String, ing):
	var pot = allPotions.get(_potName) 
	
	# If potion doesnt exist, its a dud
	if pot == null:
		var potion = createPotion(
			_potName,
			"This potion does nothing but taste bad",
			1,
			"res://assets/potions/CTCBox.jpg",
			ing,
			0,
			0
			)
		allPotions.set(_potName, potion)
		pot = allPotions.get(_potName) 
		
	# Unlock it and add it to list
	pot.unlocked = true
	_unlockedPotions.set(_potName, pot)
	

	
