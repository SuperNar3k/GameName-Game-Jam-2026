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

var NPCBirthingPod = npc_birthing_pod.new() # Used for giving birth to NPCs
var QuestCreator = Quest_Creator.new() # Used for creating quests

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$dayDuration.set_wait_time(dayDuration)
	
	#Variable that will hold all of our objects
	var item = preload("res://Scenes/item.tscn").instantiate()
	
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
	
	item = preload("res://Scenes/item.tscn").instantiate()
	
	item.createPotion(
		"epic fucking monkey",
		"curious af",
		0,
		"res://assets/potions/funny_monkey.jpg",
		[1,1,2],
		0
	)
	potions.append(item)
	
	item = preload("res://Scenes/item.tscn").instantiate()
	
	item.createPotion(
		"test name 3",
		"test desc 3",
		0,
		"res://assets/potions/three.jpg",
		[0,1,2],
		0
	)
	potions.append(item)
	
	item = preload("res://Scenes/item.tscn").instantiate()
	
	item.createPotion(
		"test name 4",
		"test desc 4",
		0,
		"res://assets/potions/four.jpg",
		[0,2,2],
		0
	)
	potions.append(item)
	
	item = preload("res://Scenes/item.tscn").instantiate()
	
	item.createPotion(
		"test name 5",
		"test desc 5",
		0,
		"res://assets/potions/five.jpg",
		[1,2,2],
		0
	)
	potions.append(item)
	
	item = preload("res://Scenes/item.tscn").instantiate()
	
	item.createPotion(
		"test name 6",
		"test desc 6",
		0,
		"res://assets/potions/six.jpg",
		[2,2,2],
		0
	)
	potions.append(item)
	NPCBirthingPod.Populate()
	
	#TEMP
	var i = 0
	while i < potions.size():
		potions[i].unlocked = true
		i = i + 1
	#potions[0].unlocked = true
	#potions[1].unlocked = true
	#TEMP
	#Hardcoding all of our Quests here:
	quests.append(QuestCreator.createQuest(
		["Hi, can you make me", "some cinnamon milk?"],						#QuestStartDialog
		["Ugh, you got that milk yet?"],									#QuestReturningDialog
		["Aw, that's okay bitch","I'll get my milk from somewhere else!"],	#QuestRejectedDialog
		["What a waste of my time", "I hope you get eaten by a dragon"],	#QuestFailedDialog
		["Oh my gosshhhh thank youuuuu!", "SLURP SLURP SLURP"],				#QuestSuccses
		[0],																#Requirements
		69,																	#RewardMoney
		[],																	#RewardRecipes
		[0,2],																#RewardIngredients
		1,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Brenna Tallowmere",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	))
	
	quests.append(QuestCreator.createQuest(
		["Adventurer! I require", "a vial of destiny!"],                    
		["Have you returned with the dew of destiny?"],                                 
		["A tragedy! A cosmic failure!","I shall seek another hero."],  
		["The stars weep for your incompetence."],  
		["Marvelous! The cosmos sings!","I can't wait to hear the music!"],              
		[0],                                                                
		69,                                                                 
		[],                                                                 
		[0,2],                                                              
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Adventurer",
		NPCBirthingPod
	))
	quests.append(QuestCreator.createQuest(
		["Hi… um… can I buy a little Glow‑Up Potion?", "I wanna shine like the heroes!"],                    
		["Did you make my Glow‑Up Potion yet?"],                                 
		["Oh… okay…", "I guess I’ll stay normal today."],  
		["Aww… I really wanted to sparkle…"],  
		["YAY!! I’m gonna glow so bright!!", "SLURP!!"],              
		[0],                                                                
		69,                                                                 
		[],                                                                 
		[0,2],                                                              
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Child",
		NPCBirthingPod
	))

	quests.append(QuestCreator.createQuest(
		["Hey there, I need a Potion of Relief.", "Long day… brain’s buzzing."],                    
		["Any chance that draught is ready?"],                                 
		["Well… that’s unfortunate.", "Guess I’ll stay stressed."],  
		["Great. Another day of headaches."],  
		["Oh thank the stars!", "My mind finally feels quiet."],              
		[0],                                                                
		69,                                                                 
		[],                                                                 
		[0,2],                                                              
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Townsfolk",
		NPCBirthingPod
	))

	quests.append(QuestCreator.createQuest(
		["Potion‑maker!", "I require a Battle‑Fury Elixir before my next quest!"],                    
		["Surely the elixir is complete by now?"],                                 
		["Tch. Very well.", "I’ll fight without it."],  
		["A warrior denied their edge… disgraceful."],  
		["Excellent!", "The fury burns within me once more!"],              
		[0],                                                                
		69,                                                                 
		[],                                                                 
		[0,2],                                                              
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Adventurer",
		NPCBirthingPod
	))

	quests.append(QuestCreator.createQuest(
		["Hi… can I get a dreamy sleep syrup?", "I keep having scary dreams…"],                    
		["Um… is my syrup done yet?"],                                 
		["Oh… okay…", "I guess I’ll try to sleep without it."],  
		["I hope the nightmares don’t come back…"],  
		["Yay!! I’ll sleep so good tonight!", "SLURP SLURP!"],              
		[0],                                                                
		69,                                                                 
		[],                                                                 
		[0,2],                                                              
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Child",
		NPCBirthingPod
	))

	quests.append(QuestCreator.createQuest(
		["Hey… I need a Potion of Courage.", "There’s a rat in my basement and I’m terrified."],                    
		["Please tell me you’ve got that tonic ready…"],                                 
		["Of course not.", "Guess I’ll keep screaming at shadows."],  
		["Wonderful. Just wonderful."],  
		["YES! I feel brave already!", "Time to face that rat!"],              
		[0],                                                                
		69,                                                                 
		[],                                                                 
		[0,2],                                                              
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Townsfolk",
		NPCBirthingPod
	))

	quests.append(QuestCreator.createQuest(
		["Potion‑seller!", "I need a Potion of Stoneskin before I face the ogres."],                    
		["Is the Potion of Stoneskin ready for battle?"],                                 
		["Hmph. Then my skin shall remain soft today."],  
		["A warrior without armor… pathetic."],  
		["Excellent!", "My body feels like granite!"],              
		[0],                                                                
		69,                                                                 
		[],                                                                 
		[0,2],                                                              
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Adventurer",
		NPCBirthingPod
	))

	quests.append(QuestCreator.createQuest(
		["Hey there, I need a Potion of Luck.", "I’m gambling tonight and I need every edge."],                    
		["Any update on that tincture?"],                                 
		["Well, that’s my luck.", "Guess I’ll lose again."],  
		["Perfect. Just what I needed: more misfortune."],  
		["Yes! Tonight’s my night!", "Down the hatch!"],              
		[0],                                                                
		69,                                                                 
		[],                                                                 
		[0,2],                                                              
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Townsfolk",
		NPCBirthingPod
	))

	quests.append(QuestCreator.createQuest(
		["Hi… can I get a potion to make me happy?", "It makes sad days feel better."],                    
		["Um… is my Happy‑Heart Potion done yet?"],                                 
		["Oh… okay…", "I’ll try to cheer up on my own."],  
		["I guess today stays gloomy…"],  
		["YAY!! My heart feels warm again!", "SLURP!"],              
		[0],                                                                
		69,                                                                 
		[],                                                                 
		[0,2],                                                              
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Child",
		NPCBirthingPod
	))

	
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
