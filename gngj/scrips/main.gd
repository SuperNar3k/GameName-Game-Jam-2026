extends Node2D

#GLOBAL VARIABLES
var currency = 0
var day = 1
var dayDuration = 60
var numOfNpcs = 3

var potions = []
var ingredients = []
var quests = []

var activeQuests = []
var pharmacy = []
var storeQueue = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$dayDuration.set_wait_time(dayDuration)
	
	
	#Variable that will hold all of our objects
	var item = Item.new()
	#var item = preload("res://Scenes/item.tscn").instantiate()
	var quest = Quest.new()
	
	#Hardcoding all of our Ingredients here
	#itemName
	#description
	#amountOwned
	#sprite
	#value
	item.createIngredient(
		"abspestos",									#ItemName
		"this shit will kill you",						#Description
		1000,											#AmountOwned
		"res://assets/ingredients/abspestos.png",		#Sprite
		3												#Value
	)
	ingredients.append(item)
	
	item = Item.new()
	
	item.createIngredient(
		"crushed abspestos",
		"this shit will kill you, also its a powder now",
		0,
		"res://assets/ingredients/crushed abspestos.jpg",
		0
	)
	ingredients.append(item)
	
	item = Item.new()
	
	item.createIngredient(
		"beans",
		"staight up beans nigga",
		3,
		"res://assets/ingredients/beans.png",
		3
	)
	ingredients.append(item)
	
	item = preload("res://Scenes/item.tscn").instantiate()
	
	#Hardcoding all of our Potions here
	#itemName
	#description
	#amountOwned
	#sprite
	#recipe
	#cookLevelNeeded
	item.createPotion(
		"cinnamon toast crunch milk",			#ItemName
		"this shit yummy af",					#Description
		0,										#AmountOwned
		"res://assets/potions/CTCBox.jpg",		#Sprite
		[0,1],									#Recipe
		0										#CookLevelNeeded
	)
	potions.append(item)
	
	item = Item.new()
	
	item.createPotion(
		"epic fucking monkey",
		"curious af",
		0,
		"res://assets/potions/funny_monkey.jpg",
		[1,1,2],
		0
	)
	potions.append(item)
	
	item = Item.new()
	
	item.createPotion(
		"test name 3",
		"test desc 3",
		0,
		"res://assets/potions/three.jpg",
		[0,1,2],
		0
	)
	potions.append(item)
	
	item = Item.new()
	
	item.createPotion(
		"test name 4",
		"test desc 4",
		0,
		"res://assets/potions/four.jpg",
		[0,2,2],
		0
	)
	potions.append(item)
	
	item = Item.new()
	
	item.createPotion(
		"test name 5",
		"test desc 5",
		0,
		"res://assets/potions/five.jpg",
		[1,2,2],
		0
	)
	potions.append(item)
	
	item = Item.new()
	
	item.createPotion(
		"test name 6",
		"test desc 6",
		0,
		"res://assets/potions/six.jpg",
		[2,2,2],
		0
	)
	potions.append(item)
	
	#TEMP
	var i = 0
	while i < potions.size():
		potions[i].unlocked = true
		i = i + 1
	#potions[0].unlocked = true
	#potions[1].unlocked = true
	#TEMP
	#Hardcoding all of our Quests here:
	quest.createQuest(
		["Hi, can you make me", "some cinnamon milk?"],						#QuestStartDialog
		["You got that milk yet?"],											#QuestReturningDialog
		["That's okay bitch","I'll get my milk from somewhere else"],		#QuestRejectedDialog
		["What a waste of my time", "DIe FUcker"],							#QuestFailedDialog
		["holy fuck thank you!", "SLURP SLUR SLUP"],						#QuestSuccses
		[0],																#Requirements
		69,																	#RewardMoney
		[],																	#RewardRecipes
		[0,2],																#RewardIngredients
		1,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true																#IsRepeatable
	)
	quests.append(quest)
	
	quests[0].setNPC(0)
	
	
	#sends references of these variables to the ui script for distribution over there
	$ui.ref_storage(
		potions,
		ingredients,
		quests,
		activeQuests,
		pharmacy,
		storeQueue
	)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
