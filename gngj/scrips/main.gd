extends Node2D

#GLOBAL VARIABLES
var currency = 0
var day = 1
var dayDuration = 60
var numOfNpcs = 3

var MAX_PHARMACY_QUESTS = 5 # Max number of repeatable quests
var MAX_ACTIVE_QUESTS = 5 # Max number of active quests

var potions = [] # Unlocked potions
var ingredients = {} # Unlocked ingredients
var quests = [] # List of ALL quests

var activeQuests = [] # Accepted quests
var pharmacyQuests = [] # Repeatable quests
var storeQueue = [] # Queue of customers (only first 3 are shown)

var NPCBirthingPod = Npc_Birthing_Pod.new() # Used for giving birth to NPCs
var QuestCreator = Quest_Creator.new() # Used for creating quests
var ItemCreator = Item_Factory.new() # Used for creating quests

#@onready var bell_sfx = $BellSFX # Bell sound effect

# Called when the game starts.
func _ready() -> void:
	$dayDuration.set_wait_time(dayDuration)
	
	ItemCreator.Populate()
	NPCBirthingPod.Populate()
	QuestCreator.Populate(quests, NPCBirthingPod)
	ItemCreator.UnlockDefaultIngredients(ingredients)
	ItemCreator.UnlockDefaultPotions(potions)

	
	#sends references of these variables to the ui script for distribution over there
	$ui.ref_storage(
		potions,
		ingredients,
		quests,
		activeQuests,
		pharmacyQuests,
		storeQueue
	)

func _onGenerateQuest():
	# Choose a random quest from quest list
	var newQuest = quests.pick_random()
	# If the chosen quest is already in the activeQuests or pharmacy lists, pick a new random quest
	while activeQuests.has(newQuest) or pharmacyQuests.has(newQuest):
		newQuest = quests.pick_random()
		
	# Add new quest to the queue
	storeQueue.append(newQuest)
	
	# Trigger the bell sound effect
	#bell_sfx.play()

func _onAcceptQuest():
	# If there's no space in the activeQuests list, do nothing
	if activeQuests.size() <= MAX_ACTIVE_QUESTS:
		return false
		
		# Take the first quest in the store queue
	var nextQuest = storeQueue[0]
	storeQueue.remove_at(0)
	activeQuests.append(nextQuest)

	# Generate new quest and update queue
	_onGenerateQuest()
	_updateQueue()
	return true

func _onQuestCompleted(_quest: Quest):
	# Mark as completed
	_quest.questCompleted = true
	
	# Remove from active list
	var i = activeQuests.find(_quest)
	activeQuests.remove_at(i)
	
	# Add to pharmacyQuests list if there's space and if quest is repeatable
	if _quest.isRepeatable and pharmacyQuests.size() <= MAX_PHARMACY_QUESTS:
		pharmacyQuests.append(_quest)

	# Update currency
	currency += 1

func _updateQueue():
	# TO-DO: Disable button which allows NPC interaction
	
	var topThree = [];
	if storeQueue.size() == 0:
		return topThree;
	elif storeQueue.size() == 1:
		topThree = [storeQueue[0]]
	elif storeQueue.size() == 2:
		topThree = [storeQueue[0], storeQueue[1]]
	else:
		topThree = [storeQueue[0], storeQueue[1], storeQueue[2]]
	
	# TO-DO: Fade out already loaded NPCs
	
	# TO-DO: Fade in new NPCs based on topThree
	
	# TO-DO: Re-enable button which allows NPC interaction
	
	
	return topThree;

func onIngredientGrinded(i: Item):
	# Check if object can be grinded
	var crushedName = "crushed " + i.itemName
	if !(crushedName in ItemCreator.allIngredients):
		return false
	
	# If not unlocked, unlock it!
	if !(crushedName in ingredients):
		ingredients.set(crushedName, ItemCreator.allIngredients.get(crushedName))
	
	# Increase crushed quantity by 1
	ingredients.get(crushedName).amountOwned += 1
	
	# Decrease quantity by 1
	var index = ingredients.find(i)
	var iObj = ingredients[index]
	iObj.amountOwned -= 1
	
	return true
	
	

func end_of_day():
	day += 1;
	
	# Tick tock, time is running out!
	for q in storeQueue:
		q.daysUntilDue -= 1
		if q.daysUntilDue == 0:
			var i = storeQueue.find(q)
			storeQueue.remove_at(i)
			
	for q in activeQuests:
		q.daysUntilDue -= 1
		if q.daysUntilDue == 0:
			var i = activeQuests.find(q)
			activeQuests.remove_at(i)
			
	for q in pharmacyQuests:
		q.daysUntilDue -= 1
		if q.daysUntilDue == 0:
			var i = pharmacyQuests.find(q)
			pharmacyQuests.remove_at(i)

	# TO-DO: if grinding in-progress, pause the grinding timer
	
	# TO-DO: if potion making was in-progress, immediately complete the potion
	
	# TO-DO: show EndOfDay popup node (Store node)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
