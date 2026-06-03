extends Node2D

#GLOBAL VARIABLES
var currency = 10
var day = 1
var dayDuration = 90
var timerStarted = false
var numOfNpcs = 3
var dudCounter = 1

var MAX_PHARMACY_QUESTS = 5 # Max number of repeatable quests
var MAX_ACTIVE_QUESTS = 5 # Max number of active quests

var potions = {} # Dictionary of unlocked potions
var ingredients = {} # Dictionary of unlocked ingredients
var quests = [] # Array of ALL quests

var availableNPCS = [] #Array of quests that are availble
var activeQuests = [] # Accepted quests
var pharmacyQuests = [] # Repeatable quests
var storeQueue = [] # Aray of customers (only first 3 are shown)

var NPCBirthingPod = Npc_Birthing_Pod.new() # Used for giving birth to NPCs
var QuestCreator = Quest_Creator.new() # Used for creating quests
var ItemCreator = Item_Factory.new() # Used for creating quests

#@onready var bell_sfx = $BellSFX # Bell sound effect
signal optionChosen
signal noLongerInConversation
var questAccepted
var inConversation = false

signal noLongerNotifying
var inNotification = false
var notificationQueue = []

signal gameAutoSaved
var saving = false
var justLoaded = false


var bellSFX = preload("res://assets/sound/Service Bell.wav")
var buySFX = preload("res://assets/sound/Coin.wav")


# Called when the game starts.
func _ready() -> void:

	$ui/MainMenuScene/phys_buttons.open_button_pressed.connect(music_fade.bind())
	$mmmusic.play()
	$introLetter.hide()
	$gameWonScreen.hide()
	
	$dayTimer.set_wait_time(dayDuration)
	#$dayTimer.timeout.connect(endOfDay)
	
	
	
	ItemCreator.Populate()
	NPCBirthingPod.Populate()
	
	#sends references of these variables to the ui script for distribution over there
	$ui.ref_storage(
		ItemCreator,
		ItemCreator.allPotions,
		ItemCreator.allIngredients,
		quests,
		activeQuests,
		pharmacyQuests,
		storeQueue,
		potions
	)
	
func _process(_delta: float):
	notificationQueueHandler()
	if(timerStarted == true):
		$ui/Hud.updateTimer($dayTimer)


func startOfDay():
	
	
	
	print("Start of day: ", day)
	
	
	if !justLoaded:
		autoSave()
		print("waiting for game to auto save")
		if saving: 
			await gameAutoSaved
		
		print("auto saved finished, resuming game")
	else:
		justLoaded = false
	
	$ui/Hud/gameInfo/dayCounter.text = "Day: " + str(day)
	
	if(day == 1):
		#$music.play()
		$introLetter.show()
		await ($introLetter.pressed)
		
		$day1music.play()
		
		giveIngredient(ItemCreator.allIngredients.get("earth"))
	
		giveIngredient(ItemCreator.allIngredients.get("leaf of a thousand leaves"))
		giveIngredient(ItemCreator.allIngredients.get("leaf of a thousand leaves"))
	
		giveIngredient(ItemCreator.allIngredients.get("a thorny heart"))
		giveIngredient(ItemCreator.allIngredients.get("a thorny heart"))
	
		giveIngredient(ItemCreator.allIngredients.get("tears of trees"))
		giveIngredient(ItemCreator.allIngredients.get("tears of trees"))
		
		unlockPotion(ItemCreator.allPotions.get("Heat Resistance Potion"))
		
		for NPC in NPCBirthingPod.allNPCs.values():
			availableNPCS.append(NPC)
	else:
		if day == 2:
			$day2music.play()
		if day == 3:
			$day3music.play()
		if day == 4:
			$day4music.play()
		if day == 5:
			$day5music.play()
		if day == 6:
			$day6music.play()
		if day == 7:
			$day7music.play()
		if day > 7:
			$day8music.play()
		var ingredient = ingredients.get("leaf of a thousand leaves")
		ingredient.amountOwned = ingredient.amountOwned + 2
		
		ingredient = ingredients.get("a thorny heart")
		ingredient.amountOwned = ingredient.amountOwned + 2
		
		ingredient = ingredients.get("tears of trees")
		ingredient.amountOwned = ingredient.amountOwned + 2
	
	var t
	for n in range(0, numOfNpcs):
		t = get_tree().create_timer(range(10,dayDuration-60).pick_random())
		t.timeout.connect(_onGenerateQuest)
		
	#we only pop in quest we have not completed or quest who's rewards are due
	for quest in activeQuests:
		quest.daysUntilDue = quest.daysUntilDue - 1
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
		var randPitch = (randf_range(.8, 1.2))
		$AudioStreamPlayer2D.pitch_scale = randPitch
		$AudioStreamPlayer2D.stream = bellSFX
		$AudioStreamPlayer2D.play()
		_updateQueue()
		
	$dayTimer.start(dayDuration)
	timerStarted = true
	$ui/Hud.updateCurrency(currency)
	$ui/Hud.updateTimer($dayTimer)
	
	
	
func _onGenerateQuest():
	print("Generating quest!")

	# Choose a random quest from availble quest list
	if(availableNPCS.size() > 0):		
		var newQuest = QuestCreator.createQuestForNPC(availableNPCS.pick_random().npcName, NPCBirthingPod, potions, ItemCreator.allPotions, "")
		# Add new quest to the queue
		storeQueue.append(newQuest)
		availableNPCS.erase(newQuest.npcQuestGiver)
		_updateQueue()
		
		# Trigger the bell sound effect
		# TO DO
		#bell_sfx.play()
		$AudioStreamPlayer2D.stream = bellSFX
		$AudioStreamPlayer2D.play()
	else:
		print("No more quest available for player")

func _updateQueue():
	#Disable button which allows NPC interaction
	$ui/FrontRoom/NPC.disabled = true
	
	# TO-DO: Fade out already loaded NPCs

	#Updating the textures here.
	# TO-DO :STILL HAVE TO FADE THEM IN
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
	if(storeQueue.size() > 0 && !inConversation):
		$ui/FrontRoom/NPC.disabled = false
		
#TO-DO: Maybe add sound effect for getting the reward?
func _on_greetNPC():
	print("Talking to npc")
	
	#Lock the player into the interaction
	$ui/FrontRoom/NPC.disabled = true
	$ui/FrontRoom/goToBackroom.disabled = true
	$ui/FrontRoom/Dialogue.disabled = false
	$ui/FrontRoom/Dialogue.visible = true
	inConversation = true
	
	var currentQuest = storeQueue[0]
	
	#Logic for quest on the activeQuest[] and pharmacy[]
	if (currentQuest.accepted && !currentQuest.completed) :
		
		print("In dialog for returning npc")
		
		#Display Dialog for returning npc
		for dialog in currentQuest.questDialog[1]:
			$ui/FrontRoom/Dialogue.text = dialog
			await $ui/FrontRoom/Dialogue.pressed
	
		#Check if we have the potion
		var potionWeNeed = ItemCreator.allPotions.get(currentQuest.requirements[0])
		if(potionWeNeed.amountOwned > 0 && potionWeNeed.unlocked):
			print("Giving them the potion")
			
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
			$ui/FrontRoom/AnimationPlayer.play_backwards("npc_talking")
 		
			#Dialog for quest success
			var randPitch = (randf_range(.8, 1.2))
			$giveSFX.pitch_scale = randPitch
			$giveSFX.play()
			$ui/Hud.updateCurrency(currency)
			for dialog in currentQuest.questDialog[4]:
				$ui/FrontRoom/Dialogue.text = dialog
				await $ui/FrontRoom/Dialogue.pressed
			
			
			#Giving player the reward
			currency = currency + currentQuest.rewards[0][0]
			$AudioStreamPlayer2D.stream = buySFX
			randPitch = (randf_range(.8, 1.2))
			$AudioStreamPlayer2D.pitch_scale = randPitch
			$AudioStreamPlayer2D.play()
			
			print("Giving player reward")
			$ui/Hud.updateCurrency(currency)
			if(currentQuest.daysUntilReward == 0):
				for rewardRecipe in currentQuest.rewards[1]:
					unlockPotion(ItemCreator.allPotions.get(rewardRecipe))
						
				for rewardIngredient in currentQuest.rewards[2]:
					giveIngredient(ItemCreator.allIngredients.get(rewardIngredient))
				
			#If we complete a pharmacy quest for the first time
			if(currentQuest.isRepeatable && !pharmacyQuests.has(currentQuest)):
				
				print("completed pharmacy quest for first time, adding them to pharmacyQuests[]")
				#Dialog for active quest becoming a pharmacy quest
				for dialog in currentQuest.questDialog[5]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
					
				activeQuests.erase(currentQuest)
				pharmacyQuests.append(currentQuest)
				currentQuest.daysUntilDue = currentQuest.daysUntilDueReset
				
			#If we complete a pharmacy quest 
			if(currentQuest.isRepeatable and pharmacyQuests.has(currentQuest)):
				print("Completed reoccuring pharmacyQuest, resetting the days until due")
				
				currentQuest.daysUntilDue = currentQuest.daysUntilDueReset
			#mark the one time quest as complete so they can just come back to give the reward
			elif(currentQuest.daysUntilReward > 0):
				
				print("One shot quest with delayed rewards complete Marking it done")
				currentQuest.completed = true
				
			else:
				
				print("One shot quest complete. removing it from activeQuests[] and returing the npc to pool")
				activeQuests.erase(currentQuest)
				#currentQuest.resetQuest()
				availableNPCS.append(currentQuest.npcQuestGiver)
			
				
		#If we don't have the potion logic
		else:
			
			print("no potion for npc")
			#Dialogue for quest failure
			if(currentQuest.daysUntilDue == 0):
				
				print("quest failure dialog")
				for dialog in currentQuest.questDialog[3]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
					
				print("resetting the quest")
				#Reset the quest and remove it from the list
				pharmacyQuests.erase(currentQuest)
				activeQuests.erase(currentQuest)
				#currentQuest.resetQuest()
				availableNPCS.append(currentQuest.npcQuestGiver)
				print("quest erased")
				
			else:
				
				print("npc returing dialog and logic")
				$ui/FrontRoom/Dialogue.text = "I see you don't have my potion ready. I'll check again tomorrow."
				await $ui/FrontRoom/Dialogue.pressed
				
			
	#Logic if its a first time quest!
	elif(!currentQuest.accepted):
		
		print("first time quest dialog")
		
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
			var randPitch = (randf_range(.8, 1.2))
			$giveSFX.pitch_scale = randPitch
			$giveSFX.play(.68)
			$ui/Hud.updateCurrency(currency)
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
			$AudioStreamPlayer2D.stream = buySFX
			randPitch = (randf_range(.8, 1.2))
			$AudioStreamPlayer2D.pitch_scale = randPitch
			$AudioStreamPlayer2D.play()
			
			print("giving player rewards")
			currency = currency + currentQuest.rewards[0][0]
			$ui/Hud.updateCurrency(currency)
			if(currentQuest.daysUntilReward == 0):
				
				print("giving recipe rewards")
				for rewardRecipe in currentQuest.rewards[1]:
					unlockPotion(ItemCreator.allPotions.get(rewardRecipe))
						
				for rewardIngredient in currentQuest.rewards[2]:
					giveIngredient(ItemCreator.allIngredients.get(rewardIngredient))
			
			#Logic for completing a pharmacy quest vs a one time quest
			if(currentQuest.isRepeatable):
				
				print("adding quest to pharmacyQuest[]")
				#Dialog for adding quest to pharmacy
				for dialog in currentQuest.questDialog[5]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
				
				currentQuest.accepted = true
				pharmacyQuests.append(currentQuest)
				
			#Again, if it is a one time quest, we can just do logic so they 
			#only come back to give player the rewards
			elif(currentQuest.daysUntilReward > 0):
				
				print("set the quest up for delayed return rewards")
				currentQuest.accepted = true
				currentQuest.completed = true
				activeQuests.append(currentQuest)
				
			else:
				print("resetting one shot quest")
				#currentQuest.resetQuest()
				availableNPCS.append(currentQuest.npcQuestGiver)
				
			
		#logic for either having them come back later or rejecting quest
		else:
			
			print("allowing player to decided to reject or accept")
			$ui/FrontRoom/acceptQuestButton.show()
			$ui/FrontRoom/rejectQuestButton.show()
			
			await optionChosen
			
			$ui/FrontRoom/acceptQuestButton.hide()
			$ui/FrontRoom/rejectQuestButton.hide()
			
			#If quest accepted
			if(questAccepted):
				print("quest accepted")
				currentQuest.daysUntilDue = currentQuest.daysUntilDue - 1
				currentQuest.accepted = true
				activeQuests.append(currentQuest)
				
			#If quest is rejected
			else:
				print("quest rejected")
				for dialog in currentQuest.questDialog[2]:
					$ui/FrontRoom/Dialogue.text = dialog
					await $ui/FrontRoom/Dialogue.pressed
			
				print("resetting npc and adding them to pool")
				#currentQuest.resetQuest()
				availableNPCS.append(currentQuest.npcQuestGiver)
				
	#Logic for when the npc wants to give you rewards for completing a one time quest
	elif(currentQuest.accepted && currentQuest.completed):
		print("logic for npc coming to give us delayed reward")
		print("this should not be happening btw")
		
		#Dialog for the npc saying that they came back to give more stuff
		for dialog in currentQuest.questDialog[6]:
			$ui/FrontRoom/Dialogue.text = dialog
			await $ui/FrontRoom/Dialogue.pressed
					
					
		print("giving rewards anyways?")
		#Logic for giving the rewards to the player
		for rewardRecipe in currentQuest.rewards[1]:
			unlockPotion(ItemCreator.allPotions.get(rewardRecipe))
		for rewardIngredient in currentQuest.rewards[2]:
			giveIngredient(ItemCreator.allIngredients.get(rewardIngredient))
			
		
		print("resetting quest?")
		#Reset the quest and remove it from activeQuest[]
		#currentQuest.resetQuest()
		activeQuests.erase(currentQuest)
		availableNPCS.append(currentQuest.npcQuestGiver)
	
	
	print("convo done")
	#Unlock the player from the interaction
	$ui/FrontRoom/goToBackroom.disabled = false
	$ui/FrontRoom/Dialogue.disabled = true
	$ui/FrontRoom/Dialogue.visible = false
	inConversation = false
	noLongerInConversation.emit()
	$ui/FrontRoom/AnimationPlayer.play_backwards("npc_talking")
	
	print("displaying new npc if available")
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

#this funciton might be useless
func onIngredientGrinded(i: Item):
	var crushedName:String 
	if(i.itemName == "shooting star"):
		crushedName = "stardust"
	else: 
		crushedName = i.itemName + " powder"
	
	var crushedObj:Item = ItemCreator.allIngredients.get(crushedName)
	
	# If not unlocked, unlock it!
	if !(crushedName in ingredients):
		ingredients.set(crushedName, crushedObj)
		crushedObj.unlocked = true
	
	# Increase crushed quantity by 1
	crushedObj.amountOwned += 1
	createdItem(crushedObj, "Ingredient")
	
	# Decrease quantity by 1
	i.amountOwned -= 1
	
	return crushedObj



func buyIngredient(cost: int, ingredient: Item):
	if(cost <= currency):
		currency -= cost
		$ui/Hud.updateCurrency(currency)
		$ui/crowStore.currency = currency
		$AudioStreamPlayer2D.stream = buySFX
		var randPitch = (randf_range(.8, 1.2))
		$AudioStreamPlayer2D.pitch_scale = randPitch
		$AudioStreamPlayer2D.play()
		giveIngredient(ingredient)
		

func giveIngredient(i: Item):
	# If not unlocked, unlock it!
	if !(i.itemName in ingredients):
		ItemCreator.UnlockIngredient(ingredients,i.itemName)
		ingredients.set(i.itemName, i)
		i.unlocked = true
		
		print("ingredient: ", i.itemName, " unlocked")
		
		notificationQueue.append(i)
		notificationQueue.append("Ingredient")
		
	# Increase quantity by 1
	if(i.itemName != "earth"):
		i.amountOwned += 1
	
	
func notifcationFinished():
	inNotification = false
	noLongerNotifying.emit()


func notificationQueueHandler():
	if(notificationQueue.size() > 0):
		if(!inNotification):
			inNotification = true
			var item = notificationQueue[0]
			var type = notificationQueue[1]
			$ui/Notification/Popup.newItemUnlocked(item,type)
			await noLongerNotifying
			notificationQueue.pop_front()
			notificationQueue.pop_front()
	

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
			if(ingredientsUsed == p.recipe):
				potion = p
				
				if(p.itemName == "Invincibility Potion"):
					$gameWonScreen.show()
					await $gameWonScreen.pressed
					$gameWonScreen.hide()
				break

	# Set to dud if recipe not found
	if potion == null:
		var potionName = "Dud " + str(dudCounter)
		var potionSprite
		if(dudCounter%4 == 0):
			potionSprite = "res://assets/potions/Dud Potion Large Round Bottle.PNG"
		elif(dudCounter%4 == 1):
			potionSprite = "res://assets/potions/Dud Potion round bottle long neck.PNG"
		elif(dudCounter%4 == 2):
			potionSprite = "res://assets/potions/Dud Potion Square Bottle.PNG"
		else:
			potionSprite = "res://assets/potions/Dud Potion Vial.PNG"
			
		var potionRecipe = []
			
		for ingredient in ingredientsUsed:
			potionRecipe.append(ingredient)
			
		potion = ItemCreator.createPotion(
			potionName,
			"This potion does nothing but taste bad",
			0,
			potionSprite,
			potionRecipe,
			0,
			0
		)
		dudCounter = dudCounter + 1
		print("new dud created")
	else:
		createdItem(potion, "Potion")
		
		
	# Unlock if needed, and increase quantity
	unlockPotion(potion)
	potion.amountOwned += 1

func unlockPotion(p: Item):
	# If not unlocked, unlock it!
	if !(p.itemName in potions):
		ItemCreator.UnlockPotion(potions, p.itemName, null)
		potions.set(p.itemName, p)
		p.unlocked = true
		
		print("potion: ", p.itemName, " unlocked")
		
		notificationQueue.append(p)
		notificationQueue.append("Potion")

func createdItem(i: Item, type: String):
	$ui/Notification/Popup.itemMade(i, type)


#TO-DO: LOGIC FOR WHEN DAY ENDS AND PLAYER IS IN THE MIDDLE OF MAKING STUFF
func endOfDay():
	timerStarted = false
	print("End of day: ", day)
		
	if(inConversation):
		print("cant end day because in conversation")
		await noLongerInConversation
	
	
	$ui/RecipeBook._on_exit_btn_pressed()
	
	# Transition to End of Day Screen
	$"ui/SceneTransition".fadeIn()
	await get_tree().create_timer(0.2).timeout
	$ui.endDay() # End day in UI
	$"ui/SceneTransition".fadeOut()
	
	# Increment day
	day += 1;
	
	#Logic for handling quest still in the queue when the day ends
	for i in range(storeQueue.size() - 1, -1, -1):
		var q = storeQueue[i]
		#Any npcs on their deadlines are removed from player quest.
		if q.daysUntilDue == 0:
			activeQuests.erase(q)
			pharmacyQuests.erase(q)
			
		#all else will comeback the next day
		else:
			q.daysUntilDue -= 1
			
	storeQueue.clear()
	_updateQueue()
	
	# If potion making was in-progress, give ingredients back
	for i in $ui/CauldronStation.held_ingredients:
		giveIngredient(ingredients.get(i))
	
	music_fade()
	
	$ui/crowStore.currency = currency
	$ui/crowStore.checkIfTooBroke()
	$ui._on_end_of_day()
	


func _on_intro_letter_pressed() -> void:
	$ui/Hud.show()
	get_tree().paused = false
	$introLetter.hide()

func music_fade():
	if $mmmusic.playing == true:
		_on_animation_player_animation_finished("mm_music_fade_anim")
	if $day1music.playing == true:
		_on_animation_player_animation_finished("day1_music_fade_anim")
	if $day2music.playing == true:
		_on_animation_player_animation_finished("day2_music_fade_anim")
	if $day3music.playing == true:
		_on_animation_player_animation_finished("day3_music_fade_anim")
	if $day4music.playing == true:
		_on_animation_player_animation_finished("day4_music_fade_anim")
	if $day5music.playing == true:
		_on_animation_player_animation_finished("day5_music_fade_anim")
	if $day6music.playing == true:
		_on_animation_player_animation_finished("day6_music_fade_anim")
	if $day7music.playing == true:
		_on_animation_player_animation_finished("day7_music_fade_anim")
	if $day8music.playing == true:
		_on_animation_player_animation_finished("day8_music_fade_anim")

func _on_mmmusic_finished() -> void:
	$mmmusic.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "mm_music_fade_anim":
		$mmmusic.stop()
	if anim_name == "day1_music_fade_anim":
		$day1music.stop()
	if anim_name == "day2_music_fade_anim":
		$day2music.stop()
	if anim_name == "day3_music_fade_anim":
		$day3music.stop()
	if anim_name == "day4_music_fade_anim":
		$day4music.stop()
	if anim_name == "day5_music_fade_anim":
		$day5music.stop()
	if anim_name == "day6_music_fade_anim":
		$day6music.stop()
	if anim_name == "day7_music_fade_anim":
		$day7music.stop()
	if anim_name == "day8_music_fade_anim":
		$day8music.stop()
	else:
		pass


func _on_day_1_music_finished() -> void:
	$day1music.play()


func _on_day_2_music_finished() -> void:
	$day2music.play()


func _on_day_3_music_finished() -> void:
	$day3music.play()


func _on_day_4_music_finished() -> void:
	$day4music.play()

func _on_day_5_music_finished() -> void:
	$day5music.play()


func _on_day_6_music_finished() -> void:
	$day6music.play()


func _on_day_7_music_finished() -> void:
	$day7music.play()


func _on_day_8_music_finished() -> void:
	$day8music.play()

func autoSave():
	print("auto saving game")
	saving = true
	
	var saveFile = FileAccess.open("user://pp.save", FileAccess.WRITE)
	
	var saveday = day
	var savecurrency = currency
	
	var saveIngredients = {}
	var savePotions = {}
	var saveActiveQuests = {}
	var savePharmacyQuests = {}
	
	
	for potion in potions.values():
		savePotions.set(potion.itemName, potion.amountOwned)
		
	for ingredient in ingredients.values():
		saveIngredients.set(ingredient.itemName, ingredient.amountOwned)
		
	for aQuest in activeQuests:
		var questData = {}
		questData.set("Quest completed", aQuest.completed)
		questData.set("Days until due", aQuest.daysUntilDue)
		questData.set("Days until reward", aQuest.daysUntilReward)
		questData.set("Required potion", aQuest.requirements[0])
		
		saveActiveQuests.set(aQuest.npcQuestGiver.npcName, questData)

	for pQuest in pharmacyQuests:
		var questData = {}
		questData.set("Quest completed", pQuest.completed)
		questData.set("Days until due", pQuest.daysUntilDue)
		questData.set("Required potion", pQuest.requirements[0])
		
		savePharmacyQuests.set(pQuest.npcQuestGiver.npcName, questData)
		
	
	var jsonString
	jsonString = JSON.stringify(saveday)
	saveFile.store_line(jsonString)
	
	jsonString = JSON.stringify(savecurrency)
	saveFile.store_line(jsonString)
	
	jsonString = JSON.stringify(saveIngredients)
	saveFile.store_line(jsonString)
	
	jsonString = JSON.stringify(savePotions)
	saveFile.store_line(jsonString)
	
	jsonString = JSON.stringify(saveActiveQuests)
	saveFile.store_line(jsonString)
	
	jsonString = JSON.stringify(savePharmacyQuests)
	saveFile.store_line(jsonString)
	
	print("finised writing save file")
	saving = false
	gameAutoSaved.emit()
	
func loadGame():
	print("loading saved game file")
	
	if not FileAccess.file_exists("user://pp.save"):
		print("no save data found!")
		return
		
	var saveFile = FileAccess.open("user://pp.save", FileAccess.READ)
	var json = JSON.new()
	var jsonString
	
	print("importing day")
	jsonString = saveFile.get_line()
	json.parse(jsonString)
	day = int(json.data)
	
	print("importing currency")
	jsonString = saveFile.get_line()
	json.parse(jsonString)
	currency = int(json.data)
	
	print("importing ingredients")
	jsonString = saveFile.get_line()
	json.parse(jsonString)
	var ingredientDict = json.data
	for ingredient in ingredientDict.keys():
		ItemCreator.UnlockIngredient(ingredients, ingredient)
		ingredients.get(ingredient).amountOwned = int(ingredientDict.get(ingredient))
	
	print("importing potions")
	jsonString = saveFile.get_line()
	json.parse(jsonString)
	var potionDict = json.data
	for potion in potionDict.keys():
		var p = ItemCreator.allPotions.get(potion)
		potions.set(potion, p)
		p.amountOwned = int(potionDict.get(potion))
		p.unlocked = true
		
	for NPC in NPCBirthingPod.allNPCs.values():
		availableNPCS.append(NPC)	
		
	print("importing active quests")
	jsonString = saveFile.get_line()
	json.parse(jsonString)
	var activeQuestDict = json.data
	for npcName in activeQuestDict.keys():
		var savedQuest = activeQuestDict.get(npcName)
		var quest = QuestCreator.createQuestForNPC(npcName, NPCBirthingPod, potions, ItemCreator.allPotions, savedQuest.get("Required potion"))
		quest.npcQuestGiver.npcName = npcName
		quest.completed = savedQuest.get("Quest completed")
		quest.daysUntilDue = int(savedQuest.get("Days until due"))
		quest.daysUntilReward = int(savedQuest.get("Days until reward"))
		quest.accepted = true
		
		activeQuests.append(quest)
		availableNPCS.erase(quest.npcQuestGiver)
	
	print("importing pharmacy quests")
	jsonString = saveFile.get_line()
	json.parse(jsonString)
	var pharmacyQuestDict = json.data
	for npcName in pharmacyQuestDict.keys():
		var savedQuest = pharmacyQuestDict.get(npcName)
		var quest = QuestCreator.createQuestForNPC(npcName, NPCBirthingPod, potions, ItemCreator.allPotions, savedQuest.get("Required potion"))
		quest.npcQuestGiver.npcName = npcName
		quest.completed = savedQuest.get("Quest completed")
		quest.daysUntilDue = int(savedQuest.get("Days until due"))
		quest.accepted = true
		
		pharmacyQuests.append(quest)
		availableNPCS.erase(quest.npcQuestGiver)
		
	print("loading complete")
	
	$ui/Hud.show()
	
	justLoaded = true
	startOfDay()
