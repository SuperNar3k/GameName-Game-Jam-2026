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
	var item = preload("res://Scenes/item.tscn").instantiate()
	
	#Hardcoding all of our Ingredients here
	item.createIngredient(
		"abspestos",
		"this shit will kill you",
		1000,
		"res://assets/ingredients/abspestos.png",
		3
	)
	ingredients.append(item)
	
	item = preload("res://Scenes/item.tscn").instantiate()
	
	item.createIngredient(
		"crushed abspestos",
		"this shit will kill you, also its a powder now",
		0,
		"res://assets/ingredients/crushed abspestos.jpg",
		0
	)
	ingredients.append(item)
	
	item = preload("res://Scenes/item.tscn").instantiate()
	
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
	item.createPotion(
		"cinnamon toast crunch milk",
		"this shit yummy af",
		0,
		"res://assets/potions/CTCBox.jpg",
		[0,1],
		0
	)
	potions.append(item)
	
	#sends references of these variables to the ui script for distribution over there
	$ui.ref_storage(
		potions,
		ingredients,
		quests,
		activeQuests,
		pharmacy,
		storeQueue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
