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
signal optionChosen
var questAccepted

# Called when the game starts.
func _ready() -> void:
	$dayDuration.set_wait_time(dayDuration)
	
	ItemCreator.Populate()
	NPCBirthingPod.Populate()
	QuestCreator.Populate(quests, NPCBirthingPod)
	ItemCreator.UnlockDefaultIngredients(ingredients)
	ItemCreator.UnlockDefaultPotions(potions)

		
	#FOR TESTING questReset()
	var quest1 = quests[0]
	
	print("quest1 original npc name: ", quest1.npcQuestGiver.npcName)
	print("quest1 original daysUntilDue: ", quest1.daysUntilDue)
		
	quest1.daysUntilDue = 0
	
	print("quest1 changed daysUntilDue: ", quest1.daysUntilDue)
	
	quest1.resetQuest()
	
	print("quest1 reset npc name: ", quest1.npcQuestGiver.npcName)
	print("quest1 reset daysUntilDue: ", quest1.daysUntilDue)
	
	
	#FOR TESTING updateQueue and on_greetNPC()
	_onGenerateQuest()
	_onGenerateQuest()
	_onGenerateQuest()
	
	
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
	while activeQuests.has(newQuest) or pharmacyQuests.has(newQuest) or storeQueue.has(newQuest):
		newQuest = quests.pick_random()
		print("help")
		
	
		
	# Add new quest to the queue
	storeQueue.append(newQuest)
	_updateQueue()
	# Trigger the bell sound effect
	#bell_sfx.play()


func _updateQueue():
	#Disable button which allows NPC interaction
	$ui/FrontRoom/NPC.disabled = true
	
	# TO-DO: Fade out already loaded NPCs

	#Updating the textures here. TO-DO :STILL HAVE TO FADE THEM IN
	if storeQueue.size() == 0: 
		$ui/FrontRoom/NPC.set_texture_normal(null)
		$ui/FrontRoom/customer2.set_texture(null)
		$ui/FrontRoom/customer3.set_texture(null)
	elif storeQueue.size() == 1:
		$ui/FrontRoom/NPC.set_texture_normal(load(storeQueue[0].npcQuestGiver.sprite))
		$ui/FrontRoom/customer2.set_texture(null)
		$ui/FrontRoom/customer3.set_texture(null)
	elif storeQueue.size() == 2:
		$ui/FrontRoom/NPC.set_texture_normal(load(storeQueue[0].npcQuestGiver.sprite))
		$ui/FrontRoom/customer2.set_texture(load(storeQueue[1].npcQuestGiver.sprite))
		$ui/FrontRoom/customer3.set_texture(null)
	elif storeQueue.size() >= 3:
		$ui/FrontRoom/NPC.set_texture_normal(load(storeQueue[0].npcQuestGiver.sprite))
		$ui/FrontRoom/customer2.set_texture(load(storeQueue[1].npcQuestGiver.sprite))
		$ui/FrontRoom/customer3.set_texture(load(storeQueue[2].npcQuestGiver.sprite))

	#Re-enable button which allows NPC interaction
	if(storeQueue.size() > 0):
		$ui/FrontRoom/NPC.disabled = false
		

func _on_greetNPC():
	#Lock the player into the interaction
	$ui/FrontRoom/NPC.disabled = true
	$ui/FrontRoom/goToBackroom.disabled = true
	$ui/FrontRoom/Dialogue.disabled = false
	$ui/FrontRoom/Dialogue.visible = true
	
	var currentQuest = storeQueue.pop_front()
	
	#Logic for quest on the activeQuest[] and pharmacy[]
	if (currentQuest.accepted && !currentQuest.questCompleted) :
		
		#Display Dialog for returning npc
		for dialog in currentQuest.questDialog[1]:
			$ui/FrontRoom/Dialogue.text = dialog
			await $ui/FrontRoom/Dialogue.pressed
	
		#Check if we have the potion
		var potionWeNeed = potions.values()[currentQuest.requirements[0]]
		if(potionWeNeed.amountOwned > 0):
			$ui/FrontRoom/potionHotBar.visible = true
			
			
			#TO-DO: MORE LOGIC FOR BEING ABLE TO SELECT THE CORRECT POTION
			#ONLY DISPLAY THE givePotionButton if the selceted potion is the 
			#potion that the npc needs!
			
			#Wait to select the potion and reduce the amount we own
			await $ui/FrontRoom/givePotionButton.pressed
			potionWeNeed.amountOwned = potionWeNeed.amountOwned - 1
 		
			#Dialog for quest success
			for dialog in currentQuest.questDialog[4]:
				$ui/FrontRoom/Dialogue.text = dialog
				await $ui/FrontRoom/Dialogue.pressed
				
			#TO-DO: Add giving the player the reward logic
			
			
			#reset the timer for when the pharmacy potion is due
			if(currentQuest.isRepeatable):
				currentQuest.daysUntilDue = currentQuest.daysUntilDueReset
				
			#mark the one time quest as complete so they can just come back to give the reward
			else:
				currentQuest.questCompleted = true
				
		#If we don't have the potion logic
		else: 
			
			#Dialogue for quest failure
			if(currentQuest.daysUntilDue == 0):
				for dialog in currentQuest.questDialog[3]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
					
				#Reset the quest and remove it from the list
				currentQuest.resetQuest()
				if(currentQuest.isRepeatable):
					pharmacyQuests.erase(currentQuest)
				else:
					activeQuests.erase(currentQuest)
					
			else:
				currentQuest.daysUntilDue = currentQuest.daysUntilDue - 1 
			
	#Logic if its a first time quest!
	elif(!currentQuest.accepted):
		#Display Dialog for starting quest
		for dialog in currentQuest.questDialog[0]:
			$ui/FrontRoom/Dialogue.text = dialog
			await $ui/FrontRoom/Dialogue.pressed
		
		#Check if we have the potion 
		var potionWeNeed = potions.values()[currentQuest.requirements[0]]
		if(potionWeNeed.amountOwned > 0):
			$ui/FrontRoom/potionHotBar.visible = true
			
			#TO-DO: MORE LOGIC FOR BEING ABLE TO SELECT THE CORRECT POTION
			#ONLY DISPLAY THE givePotionButton if the selceted potion is the 
			#potion that the npc needs!
			
			#Wait to select the potion and reduce the amount we own
			await $ui/FrontRoom/givePotionButton.pressed
			potionWeNeed.amountOwned = potionWeNeed.amountOwned - 1
 		
			#Dialog for quest success
			for dialog in currentQuest.questDialog[4]:
				$ui/FrontRoom/Dialogue.text = dialog
				await $ui/FrontRoom/Dialogue.pressed
			
			#logic for completing a pharmacy quest vs a one time quest
			if(currentQuest.isRepeatable):
				
				#TO-DO: HAVE A DIALOG SHOW UP FOR ADDING THEM TO THE PHARMACY LIST
				
				currentQuest.accepted = true
				pharmacyQuests.append(currentQuest)
			
			#Again, if it is a one time quest, we can just do logic so they 
			#only come back to give player the rewards
			else:
				currentQuest.accepted = true
				currentQuest.questCompleted = true
				activeQuests.append(currentQuest)
				
			
		#logic for either having them come back later or rejecting quest
		else:
			$ui/FrontRoom/acceptQuestButton.show()
			$ui/FrontRoom/rejectQuestButton.show()
			
			await optionChosen
			
			$ui/FrontRoom/acceptQuestButton.hide()
			$ui/FrontRoom/rejectQuestButton.hide()
			
			#If quest accepted
			if(questAccepted):
				currentQuest.daysUntilDue = currentQuest.daysUntilDue - 1 
				currentQuest.accepted = true
				activeQuests.append(currentQuest)
				
			#If quest is rejected
			else:
				for dialog in currentQuest.questDialog[2]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
			
				currentQuest.resetQuest()
				
	#Logic for when the npc wants to give you rewards for completing a one time quest
	elif(currentQuest.accepted && currentQuest.questCompleted):
		
		#TO-DO: Add the dialog for the npc saying that they came back to give more stuff
		
		#TO-DO: Logic for giving the rewards to the player
		
		#Reset the quest and remove it from activeQuest[]
		currentQuest.resetQuest()
		activeQuests.erase(currentQuest)
	
	#Unlock the player from the interaction
	$ui/FrontRoom/goToBackroom.disabled = false
	$ui/FrontRoom/Dialogue.disabled = true
	$ui/FrontRoom/Dialogue.visible = false
	
	_updateQueue()

func _on_ui_quest_accepted(option: Variant):
	questAccepted = option
	optionChosen.emit()
			
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
	
