extends Node2D

#GLOBAL VARIABLES
var currency = 0
var day = 1
var dayDuration = 60
var numOfNpcs = 3

var MAX_PHARMACY_QUESTS = 5 # Max number of repeatable quests
var MAX_ACTIVE_QUESTS = 5 # Max number of active quests

var potions = {} # Dictionary of unlocked potions
var ingredients = {} # Dictionary of unlocked ingredients
var quests = [] # Array of ALL quests

var activeQuests = [] # Accepted quests
var pharmacyQuests = [] # Repeatable quests
var storeQueue = [] # Aray of customers (only first 3 are shown)

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

	#FOR TESTING
	var i = 0
	var quest
	while(i < 3):
		quest = quests.pick_random()
		pharmacyQuests.append(quest)
		i = i + 1
	while(i < 15):
		quest = quests.pick_random()
		activeQuests.append(quest)
		i = i + 1
	
	#sends references of these variables to the ui script for distribution over there
	$ui.ref_storage(
		ItemCreator.allPotions,
		ItemCreator.allIngredients,
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
	if activeQuests.size() > MAX_ACTIVE_QUESTS:
		return false
		
	# If there's no quest in the store queue, do nothing
	# Note: this should never happen, but is here to prevent an out-of-bounds exception
	if storeQueue.size() == 0:
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

	### Give rewards
	
	# Reward money
	currency += _quest.rewards[0]
	
	# Reward recipes (unlock them)
	for r:String in _quest.rewards[1]:
		var newPot:Item = ItemCreator.allPotions.get(r)
		unlockPotion(newPot)
	
	# Reward ingredients
	for r:String in _quest.rewards[2]:
		var newIng:Item = ItemCreator.allIngredients.get(r)
		giveIngredient(newIng)

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
	var crushedName:String = "crushed " + i.itemName
	if !(crushedName in ItemCreator.allIngredients):
		return false
	
	# If not unlocked, unlock it!
	if !(crushedName in ingredients):
		var crushedObj:Item = ItemCreator.allIngredients.get(crushedName)
		ingredients.set(crushedName, crushedObj)
		crushedObj.unlocked = true
	
	# Increase crushed quantity by 1
	ingredients.get(crushedName).amountOwned += 1
	
	# Decrease quantity by 1
	i.amountOwned -= 1
	
	return true

func unlockPotion(p: Item):
	# If not unlocked, unlock it!
	if !(p in potions):
		potions.set(p.itemName, p)
		p.unlocked = true
		
		# TO-DO: POPUP NEWITEM FOR NEW UNLOCKED POTION

func giveIngredient(i: Item):
	# If not unlocked, unlock it!
	if !(i in ingredients):
		ingredients.set(i.itemName, i)
		i.unlocked = true

	# Increase quantity by 1
	i.amountOwned += 1

func onCreatePotion(ingredientsUsed: Array, cookedLevel: int):
	var potion:Item = null
	
	# Traverse the allPotions dictionary to get a match
	for p:Item in ItemCreator.allPotions.values():

		# Check if potion was found or not
		if potion != null:
			break # Exit the outer for-loop

		# Check if cook level matches and if uses same number of ingredients
		if p.cookLevelNeeded == cookedLevel and ingredientsUsed.size() == p.recipe.size():
			for ingrName:String in ingredientsUsed:
				if ingredientsUsed.count(ingrName) == p.recipe.count(ingrName):
					# Match found
					potion = p
					# TO-DO: POPUP POTION MADE!
					
					break # Exit the inner for-loop

	# Set to dud if recipe not found
	if potion == null:
		potion = ItemCreator.allPotions.get("dud")
		
	# Unlock if needed, and increase quantity
	unlockPotion(potion)
	potion.amountOwned += 1

func end_of_day():
	
	# Increment day
	day += 1;
	
	# Tick tock, time is running out!
	for i in range(storeQueue.size() - 1, -1, -1):
		var q = storeQueue[i]
		q.daysUntilDue -= 1
		if q.daysUntilDue == 0:
			storeQueue.remove_at(i)
			
	for i in range(activeQuests.size() - 1, -1, -1):
		var q = activeQuests[i]
		q.daysUntilDue -= 1
		if q.daysUntilDue == 0:
			activeQuests.remove_at(i)
			
	for i in range(pharmacyQuests.size() - 1, -1, -1):
		var q = pharmacyQuests[i]
		q.daysUntilDue -= 1
		if q.daysUntilDue == 0:
			pharmacyQuests.remove_at(i)

	# TO-DO: if grinding in-progress, pause the grinding timer
	
	# TO-DO: if potion making was in-progress, immediately complete the potion
	
	# TO-DO: show EndOfDay popup node (Store node)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
