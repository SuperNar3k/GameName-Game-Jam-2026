extends Node2D

#GLOBAL VARIABLES
var currency = 10
var day = 1
var dayDuration = 71
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

signal tutorialStep
signal cauldronTutorialComplete

var bellSFX = preload("res://assets/sound/Service Bell.wav")
var buySFX = preload("res://assets/sound/Coin.wav")

var day1MUS = preload("res://assets/sound/music/Day 1 New.mp3")
var day2MUS = preload("res://assets/sound/music/Day 2 New - selection.mp3")
var day3MUS = preload("res://assets/sound/music/Day 3 - selection.mp3")
var day4MUS = preload("res://assets/sound/music/Day 4 - selection.mp3")
var day5MUS = preload("res://assets/sound/music/Day 5 - selection.mp3")
var day6MUS = preload("res://assets/sound/music/Day 6- selection.mp3")
var day7MUS = preload("res://assets/sound/music/Day 7 - selection.mp3")
var day8MUS = preload("res://assets/sound/music/Day 8 _Full.mp3")

	
# Called when the game starts.
func _ready() -> void:
	$ui/FrontRoom.updateQueue.connect(_updateQueue.bind())
	
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
		potions,
		day
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
		
		
		$daymusic.play()
		
		## UNLOCK ALL INGREDIENTS ##
		#for ingred in ItemCreator.allIngredients.keys():
			#giveIngredient(ItemCreator.allIngredients.get(ingred))
		#ItemCreator.allIngredients.get("earth").amountOwned = 2
		#ItemCreator.allIngredients.get("a thorny heart").amountOwned = 2
		#ItemCreator.allIngredients.get("tears of trees").amountOwned = 2
			
		giveIngredient(ItemCreator.allIngredients.get("earth"))
		ItemCreator.allIngredients.get("earth").amountOwned = 1
		giveIngredient(ItemCreator.allIngredients.get("a thorny heart"))
		giveIngredient(ItemCreator.allIngredients.get("tears of trees"))
		
		
		tutorialRoutine(day)
		
		
		
		## UNLOCK ALL POTIONS ##
		#for potion in ItemCreator.allPotions.keys():
			#unlockPotion(ItemCreator.allPotions.get(potion))
		
		#unlockPotion(ItemCreator.allPotions.get("Speak With Animals Potion"))
		#unlockPotion(ItemCreator.allPotions.get("Beauty Potion"))
		#unlockPotion(ItemCreator.allPotions.get("Fog in a Bottle"))
		#unlockPotion(ItemCreator.allPotions.get("Invincibility Potion"))
		#unlockPotion(ItemCreator.allPotions.get("Invisibility Potion"))
		#unlockPotion(ItemCreator.allPotions.get("Healing Potion"))
		unlockPotion(ItemCreator.allPotions.get("Heat Resistance Potion"))
		#unlockPotion(ItemCreator.allPotions.get("Water Breathing Potion"))
		#unlockPotion(ItemCreator.allPotions.get("Water Walking Potion"))
		
		for NPC in NPCBirthingPod.allNPCs.values():
			availableNPCS.append(NPC)
	else:
		$AnimationPlayer.play("RESET")
		#$AnimationPlayer.current_animation_position = 0.0
		if day == 2:
			$daymusic.stream = day2MUS
			$daymusic.play()
		if day == 3:
			$daymusic.stream = day3MUS
			$daymusic.play()
		if day == 4:
			$daymusic.stream = day4MUS
			$daymusic.play()
		if day == 5:
			$daymusic.stream = day5MUS
			$daymusic.play()
		if day == 6:
			$daymusic.stream = day6MUS
			$daymusic.play()
		if day == 7:
			$daymusic.stream = day7MUS
			$daymusic.play()
		if day > 7:
			$daymusic.stream = day8MUS
			$daymusic.play()
		var ingredient = ingredients.get("leaf of a thousand leaves")
		ingredient.amountOwned = ingredient.amountOwned + 2
		
		ingredient = ingredients.get("a thorny heart")
		ingredient.amountOwned = ingredient.amountOwned + 2
		
		ingredient = ingredients.get("tears of trees")
		ingredient.amountOwned = ingredient.amountOwned + 2
	
	var timer = Timer.new()
	for n in range(0, numOfNpcs):
		timer.set_one_shot(true)
		add_child(timer)
		timer.start(range(10,dayDuration-60).pick_random())
		timer.timeout.connect(_onGenerateQuest)
		timer.add_to_group("npcTimers")
		
		timer = Timer.new()
		
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
	
func tutorialRoutine(Day : int):
	var pointerNode = preload("res://Scenes/pointerImage.tscn")
	
	match Day: 
		1: 
	
			$ui.inTutorial = true
			$ui/CauldronStation/IngredientDrawer.inTutorial = true
			$ui/CauldronStation.inTutorial = true
			$ui/RecipeBook.inTutorial = true

			$ui/Hud/Quests.hide()
			$ui/FrontRoom/goToBackroom.disabled = true
			
			
			#Point at recipe book
			var point = pointerNode.instantiate()
			point.global_position = Vector2(1775,160)
			add_child(point)
			point.playAnimation("pointUp")
			point.add_to_group("pointers")
			
			await tutorialStep
			point.queue_free()
			
			await tutorialStep
			
			#Point at back room button
			point = pointerNode.instantiate()
			point.rotation_degrees = 270
			point.global_position = Vector2(1700,800)
			add_child(point)
			point.playAnimation("pointUp")
			point.add_to_group("pointers")

			
			
			await tutorialStep
			point.queue_free()
			
			$ui/BackRoom/RecipeBookBtn.disabled = true
			$ui/BackRoom/toFrontRoomBtn.disabled = true
			$ui/BackRoom/MortarandPestleBtn.disabled = true
			
			#Point at cauldron
			point = pointerNode.instantiate()
			point.rotation_degrees = 270
			point.global_position = Vector2(200,450)
			add_child(point)
			point.playAnimation("pointUp")
			point.add_to_group("pointers")
			
			
			
			await tutorialStep
			point.queue_free()
			
			#Let the cauldron do the cauldron tutorial
			$ui/CauldronStation.tutorialRoutine()
			await cauldronTutorialComplete
			
			$ui/CauldronStation.inTutorial = false
			$ui/CauldronStation/IngredientDrawer.inTutorial = false
			$ui/RecipeBook.inTutorial = false
			$ui.inTutorial = false
			
			$ui/CauldronStation/IngredientDrawer/Handle.disabled = false
			$ui/Hud/Recipes.disabled = false
			$ui/FrontRoom/goToBackroom.disabled = false
			$ui/BackRoom/RecipeBookBtn.disabled = false
			$ui/BackRoom/toFrontRoomBtn.disabled = false
			$ui/BackRoom/MortarandPestleBtn.disabled = false

			$ui/Hud/Quests.show()

			ItemCreator.allIngredients.get("earth").amountOwned = 9999
			ItemCreator.allIngredients.get("tears of trees").amountOwned = 4
			giveIngredient(ItemCreator.allIngredients.get("leaf of a thousand leaves"))
			giveIngredient(ItemCreator.allIngredients.get("leaf of a thousand leaves"))
			giveIngredient(ItemCreator.allIngredients.get("a thorny heart"))
			
			
	
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
		$ui/FrontRoom/AnimationPlayer.play("npc_fade")
	elif storeQueue.size() == 2:
		var i: Texture2D = (load(storeQueue[0].npcQuestGiver.sprite))
		if $ui/FrontRoom/NPC.get_texture_normal() != i:
			$ui/FrontRoom/NPC.set_texture_normal(load(storeQueue[0].npcQuestGiver.sprite))
			$ui/FrontRoom/AnimationPlayer.play("npc_fade")
		$ui/FrontRoom/customer2.set_texture(load(storeQueue[1].npcQuestGiver.sprite))
		$ui/FrontRoom/customer3.set_texture(null)
		#$ui/FrontRoom/AnimationPlayer.play("npc_fade")
	elif storeQueue.size() >= 3:
		var i: Texture2D = (load(storeQueue[0].npcQuestGiver.sprite))
		if $ui/FrontRoom/NPC.get_texture_normal() != i:
			$ui/FrontRoom/NPC.set_texture_normal(load(storeQueue[0].npcQuestGiver.sprite))
			$ui/FrontRoom/AnimationPlayer.play("npc_fade")
		$ui/FrontRoom/customer2.set_texture(load(storeQueue[1].npcQuestGiver.sprite))
		$ui/FrontRoom/customer3.set_texture(load(storeQueue[2].npcQuestGiver.sprite))
		#$ui/FrontRoom/AnimationPlayer.play("npc_fade")

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
			$ui/FrontRoom/AnimationPlayerTalk.play_backwards("npc_talking")
 		
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
	$ui/FrontRoom/AnimationPlayerTalk.play_backwards("npc_talking")
	
	print("displaying new npc if available")
	storeQueue.pop_front()
	
	#after the animation finishes, _updateQueue() runs
	$ui/FrontRoom/AnimationPlayer.play_backwards("npc_fade")

func _on_ui_quest_accepted(option: Variant):
	questAccepted = option
	optionChosen.emit()

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
	#i.amountOwned -= 1
	
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
		
		var notif = Notification.new()
		notif.createNotification("Unlock", "Ingredient", i)
		notificationQueue.append(notif)
		
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
			
			
			var notif = notificationQueue.pop_front()
		
			if(notif.notificationType == "Unlock"):
				$ui/Notification/Popup.newItemUnlocked(notif.item, notif.itemType)
			else:
				$ui/Notification/Popup.itemMade(notif.item, notif.itemType)
			
			
			await noLongerNotifying
	

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
		var i = 0
		for potion in ItemCreator.allPotions:
			if potion == p.itemName:
				break
			else:
				i += 1
		$ui/RecipeBook._create_button(i)
		
		
	
		var notif = Notification.new()
		notif.createNotification("Unlock", "Potion", p)
		notificationQueue.append(notif)

func createdItem(i: Item, type: String):
	var notif = Notification.new()
	notif.createNotification("Create", type, i)
	notificationQueue.append(notif)


#TO-DO: LOGIC FOR WHEN DAY ENDS AND PLAYER IS IN THE MIDDLE OF MAKING STUFF
func endOfDay():
	timerStarted = false
	print("End of day: ", day)
		
	if(inConversation):
		print("cant end day because in conversation")
		await noLongerInConversation
	
	
	$ui/RecipeBook._on_exit_btn_pressed()

	#clearing grinding station when day ends
	if $ui/GrindingStation/fruitBowl.texture == null:
		pass
	else:
		$ui/GrindingStation/fruitBowl.texture = null
		$ui/GrindingStation.allIngredients.get($ui/GrindingStation.bowlIngredient).amountOwned += 1
		$ui/GrindingStation.bowlIngredient = null
		$ui/GrindingStation/IngredientDrawer.grabbingAllowed = true

	#clearing cauldron station when day ends
	if $ui/CauldronStation/ingredientsInCauldron/ingredient1/image.texture != null:
		$ui/CauldronStation/ingredientsInCauldron/ingredient1/image.set_texture(null)
		$ui/CauldronStation/IngredientDrawer.allIngredients.get($ui/CauldronStation.held_ingredients[0]).amountOwned += 1
		$ui/CauldronStation/AnimationPlayer.play_backwards("revert_color")
		$ui/CauldronStation.ingredientsDisplayed[0] = ""
		if $ui/CauldronStation/ingredientsInCauldron/ingredient2/image.texture != null:
			$ui/CauldronStation/ingredientsInCauldron/ingredient2/image.set_texture(null)
			$ui/CauldronStation/IngredientDrawer.allIngredients.get($ui/CauldronStation.held_ingredients[1]).amountOwned += 1
			$ui/CauldronStation.ingredientsDisplayed[1] = ""
			if $ui/CauldronStation/ingredientsInCauldron/ingredient3/image.texture != null:
				$ui/CauldronStation/ingredientsInCauldron/ingredient3/image.set_texture(null)
				$ui/CauldronStation/IngredientDrawer.allIngredients.get($ui/CauldronStation.held_ingredients[2]).amountOwned += 1
				$ui/CauldronStation.ingredientsDisplayed[2] = ""

	$ui/CauldronStation.held_ingredients.clear()


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
			
	storeQueue.clear()
	_updateQueue()
	
	# If potion making was in-progress, give ingredients back
	for i in $ui/CauldronStation.held_ingredients:
		giveIngredient(ingredients.get(i))
	$ui/CauldronStation.held_ingredients.clear()
	
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
	if $daymusic.playing == true:
		$AnimationPlayer.play("day1_music_fade_anim")
	#if $daymusic.playing == true:
		#_on_animation_player_animation_finished("day2_music_fade_anim")
	#if $daymusic.playing == true:
		#_on_animation_player_animation_finished("day3_music_fade_anim")
	#if $daymusic.playing == true:
		#_on_animation_player_animation_finished("day4_music_fade_anim")
	#if $daymusic.playing == true:
		#_on_animation_player_animation_finished("day5_music_fade_anim")
	#if $daymusic.playing == true:
		#_on_animation_player_animation_finished("day6_music_fade_anim")
	#if $daymusic.playing == true:
		#_on_animation_player_animation_finished("day7_music_fade_anim")
	#if $daymusic.playing == true:
		#_on_animation_player_animation_finished("day8_music_fade_anim")

func _on_mmmusic_finished() -> void:
	$mmmusic.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "mm_music_fade_anim":
		$mmmusic.stop()
	if anim_name == "day1_music_fade_anim":
		$daymusic.stop()
	#if anim_name == "day2_music_fade_anim":
		#$daymusic.stop()
	#if anim_name == "day3_music_fade_anim":
		#$daymusic.stop()
	#if anim_name == "day4_music_fade_anim":
		#$daymusic.stop()
	#if anim_name == "day5_music_fade_anim":
		#$daymusic.stop()
	#if anim_name == "day6_music_fade_anim":
		#$daymusic.stop()
	#if anim_name == "day7_music_fade_anim":
		#$daymusic.stop()
	#if anim_name == "day8_music_fade_anim":
		#$daymusic.stop()
	#else:
		#pass


func _on_day_1_music_finished() -> void:
	$daymusic.play()


#func _on_day_2_music_finished() -> void:
	#$day2music.play()
#
#
#func _on_day_3_music_finished() -> void:
	#$day3music.play()
#
#
#func _on_day_4_music_finished() -> void:
	#$day4music.play()
#
#func _on_day_5_music_finished() -> void:
	#$day5music.play()
#
#
#func _on_day_6_music_finished() -> void:
	#$day6music.play()
#
#
#func _on_day_7_music_finished() -> void:
	#$day7music.play()
#
#
#func _on_day_8_music_finished() -> void:
	#$day8music.play()

func autoSave():
	print("auto saving game")
	saving = true
	
	var saveFile = FileAccess.open("user://pp.save", FileAccess.WRITE)
	
	var saveday = day
	var savecurrency = currency
	
	var saveIngredients = {}
	var savePotions = {}
	var saveDuds = {}
	var saveActiveQuests = {}
	var savePharmacyQuests = {}
	
	
	for ingredient in ingredients.values():
		saveIngredients.set(ingredient.itemName, ingredient.amountOwned)
	
	
	#WORK ON THIS
	for potion in potions.values():
		if("Dud" in potion.itemName):
			var dudPotion = {}
			dudPotion.set("Dud recipe", potion.recipe)
			dudPotion.set("Amount owned", potion.amountOwned)
			
			saveDuds.set(potion.itemName, dudPotion)
		else: 
			savePotions.set(potion.itemName, potion.amountOwned)
		
	
		
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
	
	jsonString = JSON.stringify(saveDuds)
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
	
	print("importing non-dud potions")
	jsonString = saveFile.get_line()
	json.parse(jsonString)
	var potionDict = json.data
	for potion in potionDict.keys():
		var p = ItemCreator.allPotions.get(potion)
		potions.set(potion, p)
		p.amountOwned = int(potionDict.get(potion))
		p.unlocked = true
		var i = 0
		for buttpotion in ItemCreator.allPotions:
			if buttpotion == p.itemName:
				break
			else:
				i += 1
		$ui/RecipeBook._create_button(i)
		
	print("importing dud potion")
	jsonString = saveFile.get_line()
	json.parse(jsonString)
	var dudDict = json.data
	for dud in dudDict.keys():
		var d = dudDict.get(dud)
		ItemCreator.UnlockPotion(potions,dud,d.get("Dud recipe"))
		potions.get(dud).amountOwned = int(d.get("Amount owned"))
		
		var potionSprite
		if(dudCounter%4 == 0):
			potionSprite = "res://assets/potions/Dud Potion Large Round Bottle.PNG"
		elif(dudCounter%4 == 1):
			potionSprite = "res://assets/potions/Dud Potion round bottle long neck.PNG"
		elif(dudCounter%4 == 2):
			potionSprite = "res://assets/potions/Dud Potion Square Bottle.PNG"
		else:
			potionSprite = "res://assets/potions/Dud Potion Vial.PNG"
			
		potions.get(dud).sprite = potionSprite
		
		dudCounter += 1
		
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


func _on_ui_pause_game() -> void:
	
	$dayTimer.set_paused(true)
	
	#NPC timer logic
	for timer in get_tree().get_nodes_in_group("npcTimers"):
		timer.set_paused(true)
		
	#Notification Logic
	$ui/Notification.hide()
	if ($ui/Notification/Popup.inMidAnimation):
		$ui/Notification/Popup/popupAnimation.pause()
		
	$ui/Notification/Popup/popupTimer.set_paused(true)
	
	#Pointers in tutorial logic
	get_tree().call_group("pointers","hide")


func _on_ui_resume_game() -> void:
	
	$dayTimer.set_paused(false)
	
	#NPC timer logic againe
	for timer in get_tree().get_nodes_in_group("npcTimers"):
		timer.set_paused(false)
		
	#Notification logic againe
	$ui/Notification.show()
	if ($ui/Notification/Popup.inMidAnimation):
		$ui/Notification/Popup/popupAnimation.play()
	$ui/Notification/Popup/popupTimer.set_paused(false)
	
	#Pointers in tutorial logic
	get_tree().call_group("pointers","show")


func _on_ui_tutorial_step() -> void:
	tutorialStep.emit()


func _on_ui_tutorial_cauldron_station_complete() -> void:
	cauldronTutorialComplete.emit()
