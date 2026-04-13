extends Node2D

#GLOBAL VARIABLES
var currency = 50
var day = 1
var dayDuration = 90
var numOfNpcs = 3

var MAX_PHARMACY_QUESTS = 5 # Max number of repeatable quests
var MAX_ACTIVE_QUESTS = 5 # Max number of active quests

var potions = {} # Dictionary of unlocked potions
var ingredients = {} # Dictionary of unlocked ingredients
var quests = [] # Array of ALL quests

var availableQuests = [] #Array of quests that are availble
var activeQuests = [] # Accepted quests
var pharmacyQuests = [] # Repeatable quests
var storeQueue = [] # Aray of customers (only first 3 are shown)

var NPCBirthingPod = Npc_Birthing_Pod.new() # Used for giving birth to NPCs
var QuestCreator = Quest_Creator.new() # Used for creating quests
var ItemCreator = Item_Factory.new() # Used for creating quests

#@onready var bell_sfx = $BellSFX # Bell sound effect
signal optionChosen
signal noLongerInConverstation
var questAccepted
var inConverstation = false

var bellSFX = preload("res://assets/sound/vine-boom.mp3")
var buySFX = preload("res://assets/sound/cha-ching.mp3")

# Called when the game starts.
func _ready() -> void:
	$dayTimer.set_wait_time(dayDuration)
	#$dayTimer.timeout.connect(endOfDay)
	
	ItemCreator.Populate()
	NPCBirthingPod.Populate()
	QuestCreator.Populate(quests, NPCBirthingPod)
	ItemCreator.UnlockDefaultIngredients(ingredients)
	ItemCreator.UnlockDefaultPotions(potions)
	
	
	
	#sends references of these variables to the ui script for distribution over there
	$ui.ref_storage(
		ItemCreator.allPotions,
		ItemCreator.allIngredients,
		quests,
		activeQuests,
		pharmacyQuests,
		storeQueue
	)
	
	for quest in quests:
		availableQuests.append(quest)
	
	
#TO-DO: test that certain quests are being added to their proper list upon quest succsess 
#also need to make sure player is getting rewards properly 


#NEED TO FIX BUG WHERE THE RECIPE BOOK COVERS EVERYTHING
#(CANNOT SEE WHEN DAY ENDS IF YOU HAVE RECEPE BOOK OPEN)

func startOfDay():
	print("Start of day: ", day)
	
	var t 
	for n in range(0, numOfNpcs):
		t = get_tree().create_timer(range(10,dayDuration-60).pick_random())
		t.timeout.connect(_onGenerateQuest)
		
	#we only pop in quest we have not completed or quest who's rewards are due
	for quest in activeQuests:
		if(!quest.completed):
			storeQueue.append(quest)
		elif(quest.completed and quest.daysUntilReward == 0):
			storeQueue.append(quest)			
		else: 
			quest.daysUntilReward = quest.daysUntilReward - 1
		
	for quest in pharmacyQuests:
		quest.daysUntilDue = quest.daysUntilDue - 1
		if(quest.daysUntilDue == 0):
			storeQueue.append(quest)
	
	if(storeQueue.size() > 0):
		$AudioStreamPlayer2D.stream = bellSFX
		$AudioStreamPlayer2D.play()
		_updateQueue()
		
	$dayTimer.start(dayDuration)
	
	
func _onGenerateQuest():
	print("Generating quest!")

	# Choose a random quest from availble quest list
	if(availableQuests.size() > 0):
		var newQuest = availableQuests.pick_random()
		# Add new quest to the queue
		storeQueue.append(newQuest)
		availableQuests.erase(newQuest)
		_updateQueue()
		
		# Trigger the bell sound effect
		#bell_sfx.play()
		$AudioStreamPlayer2D.stream = bellSFX
		$AudioStreamPlayer2D.play()
	else: 
		print("No more quest available for player")
	
#TO-DO: ADD LOGIC FOR FADING OUT AND FADING IN NPCS
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
	if(storeQueue.size() > 0 && !inConverstation):
		$ui/FrontRoom/NPC.disabled = false
		
#TO-DO: Maybe add sound effect for getting the reward?
func _on_greetNPC():
	#Lock the player into the interaction
	$ui/FrontRoom/NPC.disabled = true
	$ui/FrontRoom/goToBackroom.disabled = true
	$ui/FrontRoom/Dialogue.disabled = false
	$ui/FrontRoom/Dialogue.visible = true
	inConverstation = true
	
	var currentQuest = storeQueue[0]
	
	#Logic for quest on the activeQuest[] and pharmacy[]
	if (currentQuest.accepted && !currentQuest.completed) :
		
		#Display Dialog for returning npc
		for dialog in currentQuest.questDialog[1]:
			$ui/FrontRoom/Dialogue.text = dialog
			await $ui/FrontRoom/Dialogue.pressed
	
		#Check if we have the potion
		var potionWeNeed = ItemCreator.allPotions.get(currentQuest.requirements[0])
		if(potionWeNeed.amountOwned > 0 && potionWeNeed.unlocked):
			
			#Logic for potion inventory
			$ui/FrontRoom/potionHotbar.show()
			$ui/FrontRoom.displayPotionsInInventory(potions.values(), potionWeNeed)
			
			#Wait to select the potion and reduce the amount we own
			await $ui/FrontRoom/givePotionButton.pressed
			potionWeNeed.amountOwned = potionWeNeed.amountOwned - 1
			
			#Hide all the shit and clean it out
			$ui/FrontRoom/potionHotbar.hide()
			$ui/FrontRoom/givePotionButton.hide()
			$ui/FrontRoom.clearInventory()
 		
			#Dialog for quest success
			for dialog in currentQuest.questDialog[4]:
				$ui/FrontRoom/Dialogue.text = dialog
				await $ui/FrontRoom/Dialogue.pressed
			
			#Giving player the reward
			currency = currency + currentQuest.rewards[0][0]
			if(currentQuest.daysUntilReward == 0):
				for rewardRecipe in currentQuest.rewards[1]:
					unlockPotion(ItemCreator.allPotions.get(rewardRecipe))
						
				for rewardIngredient in currentQuest.rewards[2]:
					giveIngredient(ItemCreator.allIngredients.get(rewardIngredient))
				
			#If we complete a pharmacy quest for the first time
			if(currentQuest.isRepeatable && !pharmacyQuests.has(currentQuest)):
				
				#Dialog for active quest becoming a pharmacy quest
				for dialog in currentQuest.questDialog[5]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
					
				activeQuests.erase(currentQuest)
				pharmacyQuests.append(currentQuest)
				
			#If we complete a pharmacy quest 
			if(currentQuest.isRepeatable and pharmacyQuests.has(currentQuest)):
				currentQuest.daysUntilDue = currentQuest.daysUntilDueReset
			#mark the one time quest as complete so they can just come back to give the reward
			elif(currentQuest.daysUntilReward > 0):
				currentQuest.completed = true
			else:
				activeQuests.erase(currentQuest)
				currentQuest.resetQuest()
				availableQuests.append(currentQuest)
				
		#If we don't have the potion logic
		else: 
			
			#Dialogue for quest failure
			if(currentQuest.daysUntilDue == 0):
				for dialog in currentQuest.questDialog[3]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
					
				#Reset the quest and remove it from the list
				pharmacyQuests.erase(currentQuest)
				activeQuests.erase(currentQuest)
				currentQuest.resetQuest()
				availableQuests.append(currentQuest)
				print("quest erased")
				
			else:
				currentQuest.daysUntilDue = currentQuest.daysUntilDue - 1 
			
	#Logic if its a first time quest!
	elif(!currentQuest.accepted):
		#Display Dialog for starting quest
		for dialog in currentQuest.questDialog[0]:
			$ui/FrontRoom/Dialogue.text = dialog
			await $ui/FrontRoom/Dialogue.pressed
		
		#Check if we have the potion 
		var potionWeNeed = ItemCreator.allPotions.get(currentQuest.requirements[0])
		if(potionWeNeed.amountOwned > 0 and potionWeNeed.unlocked):
			
			#Logic for potion inventory
			$ui/FrontRoom/potionHotbar.show()
			$ui/FrontRoom.displayPotionsInInventory(potions.values(), potionWeNeed)
			
			#Wait to select the potion and reduce the amount we own
			await $ui/FrontRoom/givePotionButton.pressed
			potionWeNeed.amountOwned = potionWeNeed.amountOwned - 1
			
			#Hide all the shit and clean it out
			$ui/FrontRoom/potionHotbar.hide()
			$ui/FrontRoom/givePotionButton.hide()
			$ui/FrontRoom.clearInventory()
			
 		
			#Dialog for quest success
			for dialog in currentQuest.questDialog[4]:
				$ui/FrontRoom/Dialogue.text = dialog
				await $ui/FrontRoom/Dialogue.pressed
			
			#Logic for giving the player the reward
			currency = currency + currentQuest.rewards[0][0]
			if(currentQuest.daysUntilReward == 0):
				for rewardRecipe in currentQuest.rewards[1]:
					unlockPotion(ItemCreator.allPotions.get(rewardRecipe))
						
				for rewardIngredient in currentQuest.rewards[2]:
					giveIngredient(ItemCreator.allIngredients.get(rewardIngredient))
			
			#Logic for completing a pharmacy quest vs a one time quest
			if(currentQuest.isRepeatable):
				
				#Dialog for adding quest to pharmacy
				for dialog in currentQuest.questDialog[5]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
				
				currentQuest.accepted = true
				pharmacyQuests.append(currentQuest)
				
			#Again, if it is a one time quest, we can just do logic so they 
			#only come back to give player the rewards
			elif(currentQuest.daysUntilDue > 0):
				currentQuest.accepted = true
				currentQuest.completed = true
				activeQuests.append(currentQuest)
				
			else:
				currentQuest.resetQuest()
				availableQuests.append(currentQuest)
				
			
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
				availableQuests.append(currentQuest)
				
	#Logic for when the npc wants to give you rewards for completing a one time quest
	elif(currentQuest.accepted && currentQuest.completed):
		
		#Dialog for the npc saying that they came back to give more stuff
		for dialog in currentQuest.questDialog[6]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
					
		#Logic for giving the rewards to the player
		for rewardRecipe in currentQuest.rewards[1]:
			unlockPotion(ItemCreator.allPotions.get(rewardRecipe))
		for rewardIngredient in currentQuest.rewards[2]:
			giveIngredient(ItemCreator.allIngredients.get(rewardIngredient))
			
				
		#Reset the quest and remove it from activeQuest[]
		currentQuest.resetQuest()
		activeQuests.erase(currentQuest)
		availableQuests.append(currentQuest)
	
	#Unlock the player from the interaction
	$ui/FrontRoom/goToBackroom.disabled = false
	$ui/FrontRoom/Dialogue.disabled = true
	$ui/FrontRoom/Dialogue.visible = false
	inConverstation = false
	noLongerInConverstation.emit()
	
	storeQueue.pop_front()
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

#Never used this lol!
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


#TO-DO: TESTING NEEDS TO BE DONE ON THIS FUNCTION
func onIngredientGrinded(i: Item):
	# Check if object can be grinded
	var crushedName:String = i.itemName + " powder"
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
	if !(p.itemName in potions):
		ItemCreator.UnlockPotion(potions, p.itemName)
		potions.set(p.itemName, p)
		p.unlocked = true
		
		print("potion: ", p.itemName, " unlocked")
		
		# TO-DO: POPUP NEWITEM FOR NEW UNLOCKED POTION

func buyIngredient(cost: int, ingredient: Item):
	if(cost <= currency):
		currency -= cost
		$ui/crowStore.currency = currency
		$AudioStreamPlayer2D.stream = buySFX
		$AudioStreamPlayer2D.play()
		giveIngredient(ingredient)
		

func giveIngredient(i: Item):
	# If not unlocked, unlock it!
	if !(i.itemName in ingredients):
		ItemCreator.UnlockIngredient(ingredients,i.itemName)
		ingredients.set(i.itemName, i)
		i.unlocked = true
		
		print("ingredient: ", i.itemName, " unlocked")
		
		#TO-DO: ALSO NEED TO ADD POP UP HERE
		
	# Increase quantity by 1
	i.amountOwned += 1
	
	

#TO-DO: TESTING NEEDS TO BE DONE ON THIS FUCNTION
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
		pass
		
		
		
	# Unlock if needed, and increase quantity
	unlockPotion(potion)
	potion.amountOwned += 1

#TO-DO: LOGIC FOR WHEN DAY ENDS AND PLAYER IS IN THE MIDDLE OF MAKING STUFF
func endOfDay():
	print("End of day: ", day)
	
	if(inConverstation):
		print("cant end day because in convestation")
		await noLongerInConverstation
	
	
	# Increment day
	day += 1;
	
	#Logic for handling quest still in the queue when the day ends
	for i in range(storeQueue.size() - 1, -1, -1):
		var q = storeQueue[i]
		#Any npcs on their deadlines are removed from player quest. GET FUCKED
		if q.daysUntilDue == 0:
			activeQuests.erase(q)
			pharmacyQuests.erase(q)
			
		#all else will comeback the next day
		else:
			q.daysUntilDue -= 1
			
	storeQueue.clear()
	_updateQueue()
	
	print("Active quest list: ", activeQuests)
		

	# TO-DO: if grinding in-progress, pause the grinding timer
	
	# TO-DO: if potion making was in-progress, immediately complete the potion
	
	$ui/crowStore.currency = currency
	$ui/crowStore.checkIfTooBroke()
	$ui._on_end_of_day()
	
	
