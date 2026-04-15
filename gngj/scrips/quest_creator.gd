class_name Quest_Creator
extends Node

func createQuest(
	_allQueststartDialog: Variant,
	_questReturingDialog: Variant,
	_questRejectedDialog: Variant,
	_questFailedDialog: Variant,
	_allQuestsuccsesDialog: Variant,
	_questJoiningPharmacyDialog: Variant,
	_questGivingDelayedRewardDialog: Variant,
	_requirements: Variant,
	_rewardMoney: Variant,
	_rewardRecipes: Variant,
	_rewardIngredients: Variant,
	_daysUntilDue: Variant,
	_daysUntilReward: Variant,
	_isReapeatable: Variant,
	_npcNameOrType: String,
	_NPCBirthingPod: Npc_Birthing_Pod
):
	var _npc = _NPCBirthingPod.BirthNPC(_npcNameOrType)
	
	var newQuest = Quest.new()
	newQuest.__init__(
		_allQueststartDialog,
		_questReturingDialog,
		_questRejectedDialog,
		_questFailedDialog,
		_allQuestsuccsesDialog,
		_questJoiningPharmacyDialog,
		_questGivingDelayedRewardDialog,
		_requirements,
		_rewardMoney,
		_rewardRecipes,
		_rewardIngredients,
		_daysUntilDue,
		_daysUntilReward,
		_isReapeatable,
		_npc
	)
	return newQuest
	
func createQuestForNPC(npcName: String, NPCBirthingPod: Npc_Birthing_Pod, potions: Dictionary, allPotions: Dictionary, numOfDuds: Variant):
	print("creating a quest")
	
	
	var cleanPotions = []
	for pName in potions.keys():
		if(!("Dud" in pName)):
			cleanPotions.append(pName)
	
	var randomPotion = cleanPotions.pick_random()
	print("The random potion was: ", randomPotion)
	
	var randomRecipeReward = allPotions.keys().pick_random()
	var quest = null
	
	match npcName:
		"Ambitious Lady In Waiting":
			quest = createQuest(
		["Hello my dear. Do you think you may take a moment to assist me?",
		"I am searching for a " + randomPotion + ". Might you have one?"],									#allQueststartDialog
		["It appears I am now your lady in waiting as I bide my time waiting for this potion.",
		"Is it ready now?"],										#QuestReturningDialog
		["Well, not the easy way then.",
		"I guess I will just have to work this situation out… the hard way."],							#QuestRejectedDialog
		["Well, you weren’t very helpful.",
		"I have much bigger problems to solve than a meddling shopkeeper.",
		"You should consider yourself lucky. Good day."],							#QuestFailedDialog
		["Amazing. This will work brilliantly in my favor.",
		"Those wretched nobles won’t even see it coming."],										#allQuestsuccses
		["Remarkable. This is a very pristine specimen."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		false,																#IsRepeatable
		"Ambitious Lady In Waiting",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
	
		"Awkward Youth":
			quest = createQuest(
		["Um… hello. You’re the shopkeeper right?",
		"Can I get a potion that will help me on an adventure?",
		"I’ve heard about a " + randomPotion + " from some of the older kids. Do you have one?"],									#allQueststartDialog
		["Hello again, I’m the one who wanted the " + randomPotion + ".",
		"Do you think it’s ready now?"],										#QuestReturningDialog
		["Do you not think I can go on an adventure either?",
		"I’m ready for it, potion or not!"],							#QuestRejectedDialog
		["I see. You don’t believe I’m ready to fight yet either, do you?",
		"I’ll show you."],							#QuestFailedDialog
		["Neato! I saved up some money for it. Let me get it all out.",
		"This is great! Thanks! Theres some slimes by the pond I think I can take on.",
		"Or maybe the wildebeasts near the forest."],										#allQuestsuccses
		["Now that I’m a proper adventurer, I can come by your shop even more.",
		"You got yourself a proper adventurer customer."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Awkward Youth",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Confident Druid":
			quest = createQuest(
		["Hey. You got a sec?",
		"I need a " + randomPotion + " for my journey. Do you know how to make one?"],									#allQueststartDialog
		["Hey, do you have the " + randomPotion + " ready?"],										#QuestReturningDialog
		["I guess I’ll have to make it myself along the way. See ya around."],							#QuestRejectedDialog
		["Well, that sucks. I wasted a lot of time in this town.",
		"I’m off. See you around."],							#QuestFailedDialog
		["Amazing, thank you for this."],										#allQuestsuccses
		["When we make it back, we’ll be sure to stop by again.",
		"We as in my party. Yeah, my party."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		false,																#IsRepeatable
		"Confident Druid",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Dirt Covered Field Hand":
			quest = createQuest(
		["Hi… I heard about this shop from a traveler.",
		"I come from a neighboring village that is being terrorized by large rats.",
		"Like humongous rats.",
		"I was wondering if you had " + randomPotion + "?"],									#allQueststartDialog
		["Hi again. Do you have a " + randomPotion + " today? If not, that's okay."],										#QuestReturningDialog
		["Oh. Well, I guess we can survive with less crops this year. Have a good day."],							#QuestRejectedDialog
		["Oh. Okay. Well, thanks for trying.",
		"We will try our best to fight them on our own unaided."],							#QuestFailedDialog
		["Thank you for this! You’re the best, you really saved the day!"],										#allQuestsuccses
		["As long as those pesky beasts keep harassing us, I’ll certainly be back.",
		"Thank you again for your help."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Dirt Covered Field Hand",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Disheveled Academic":
				quest = createQuest(
		["Are you the owner of this cluttered potion shop?",
		"I am looking to study the uses and properties of the " + randomPotion + ".",
		"Do you have one available?"],									#allQueststartDialog
		["I am back. Do you have the " + randomPotion + " now?"],										#QuestReturningDialog
		["Well, at the very least this taught me one thing.",
		"Never trust the gossip of lowly knights and squires."],							#QuestRejectedDialog
		["Well, appearances can be deceiving. In this case, perhaps not.",
		"This tiny little shop has tiny little ambitions in the realm of potion mastery."],							#QuestFailedDialog
		["This potion is spectacularly made! What a good bargain, too.",
		"I wonder what will happen if I poured some on a toad..."],										#allQuestsuccses
		["When we make it back, we’ll be sure to stop by again.",
		"We as in my party. Yeah, my party."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		false,																#IsRepeatable
		"Disheveled Academic",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Distracted Academic":
			quest = createQuest(
		["Oh. Hello.",
		"Sorry, uh. One moment... Where's that paper?",
		"Right. Do you have a " + randomPotion + "?"],									#allQueststartDialog
		["Hi again. Oh no, did I lose that paper again?",
		"I was looking for a " + randomPotion + "."],										#QuestReturningDialog
		["Bummer, guess I’ll just have to keep to the books.",
		"Thanks, bye."],							#QuestRejectedDialog
		["At least in the meantime, I made some breakthroughs in my research.",
		"Thanks for trying. Bye."],							#QuestFailedDialog
		["Thank you for this.",
		"This " + randomPotion + " will really tie my research on alchemical reactions together."],										#allQuestsuccses
		["Remarkable. This is a very pristine specimen.",
		"Much better quality than the potion master back at the castle.",
		"I may stop by here again when I have the time."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Distracted Academic",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Fearless Privateer":
			quest = createQuest(
		["Hello there, might you have a moment.",
		"I am looking to acquire some goods before heading out to sea.",
		"Would you have a " + randomPotion + "?"],									#allQueststartDialog
		["We meet again so soon.",
		"Do you have that " + randomPotion + " packed and ready?"],										#QuestReturningDialog
		["This is unfortunate news.",
		"I am sure I will find something the next time I make port.",
		"Until we meet again, farewell."],							#QuestRejectedDialog
		["Well, I am off with or without this potion either way.",
		"How much more could a " + randomPotion + " have helped with a kraken anyways.",
		"It’s all about the weapon wielder’s talent, let me tell you. Farewell."],							#QuestFailedDialog
		["Brilliant work.",
		"Thank you for granting me this. I hope this fares the voyage well.",
		"So long."],										#allQuestsuccses
		["Remarkable. This is a very pristine specimen."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		false,																#IsRepeatable
		"Fearless Privateer",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Friendly Bar Maid":
			quest = createQuest(
		["Hey there, I haven’t seen you much around the tavern.",
		"I heard that a powerful potion master built a shop nearby, you must be them!",
		"I have had some... irritating customers lately.",
		"Do you think I could get a " + randomPotion + "?"],									#allQueststartDialog
		["Hey there stranger, how have you been?",
		"Do you have the " + randomPotion + " ready?"],										#QuestReturningDialog
		["Hmm... I’ll have to get back to the drawing board on how to handle this one.",
		"See you around!"],							#QuestRejectedDialog
		["Well, this isn’t anything new.",
		"I’ll come up with a new way to handle the problem.",
		"See you around."],							#QuestFailedDialog
		["That’s it! This will work terrifically. Thank you so much.",
		"Do stop by the tavern, we’re just down the road from each other, neighbor.",
		"I’m sure you have plenty of stories, I would love to hear them over a pint."],										#allQuestsuccses
		["I’ll be sure to stop by again, you’re a great potion master!"],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Friendly Bar Maid",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"House of Rouge Knight":
			quest = createQuest(
				["Good day shopkeeper!", "I am a knight from the Noble House of Rouge.",
				"On this fine day, I am looking for " + randomPotion + ".",
				"Perchance would you be able to procure this for me?"],									#allQueststartDialog
				["Good day shopkeeper!"],										#QuestReturningDialog
				["That is most unfortunate news.","I will take my leave now."],							#QuestRejectedDialog
				["Hm, that is rather…", "Unfortunate.", "I shall take my leave now. "],							#QuestFailedDialog
				["Splendid! My quest and I thank you!"],										#allQuestsuccses
				["If this works how I think it will,", 
				"I will share your brilliance with the rest of the noble house of Rouge."],		#Joining pharmacy dialog
				[],
				[randomPotion],																#Requirements
				69,																	#RewardMoney
				[],																	#RewardRecipes
				["earth"],												#RewardIngredients
				3,																	#DaysUntilDue
				0,																	#DaysUntilReward
				false,																#IsRepeatable
				"House of Rouge Knight",												#NpcTypeOrName
				NPCBirthingPod														#Pass the birthing pod
			)
		"Intrepid Adventurer":
			quest = createQuest(
				["Heya!", "By any chance do you have " + randomPotion + "?",],									#allQueststartDialog
				["Hi again! How are you?", "Would you happen to have my potion ready?"],										#QuestReturningDialog
				["Shucks, I was really hoping to get " + randomPotion + ".", " I guess I’ll try somewhere else."],							#QuestRejectedDialog
				["Oh. Well maybe I’m unlucky now so I’m luckier later.",
				"See you around!"],							#QuestFailedDialog
				["This is great! My enemies don’t stand a chance! Thanks!"],										#allQuestsuccses
				["If this works how I think it will,", 
				""],		#Joining pharmacy dialog
				[],
				[randomPotion],																#Requirements
				69,																	#RewardMoney
				[],																	#RewardRecipes
				["earth"],												#RewardIngredients
				3,																	#DaysUntilDue
				0,																	#DaysUntilReward
				false,																#IsRepeatable
				"Intrepid Adventurer",												#NpcTypeOrName
				NPCBirthingPod														#Pass the birthing pod
			)
		"Mysterious Cloaked Noblewoman":
			quest = createQuest(
		["Excuse me - do you think you can help me?",
		"Do you have " + randomPotion + "?",],									#allQueststartDialog
		["Hello again, do you remember me?", "I needed " + randomPotion + "."],										#QuestReturningDialog
		["You don’t understand… I really need a " + randomPotion + ".",
		" If you don’t have it, where can I get it..."],							#QuestRejectedDialog
		["...I don’t know what to do now...", "*inaudible murmuring*",
		"... ah well. Have a... nice day. "],							#QuestFailedDialog
		["Thank you! This changes everything."],										#allQuestsuccses
		["You’re quite dependable. I will remember your shop!"],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Mysterious Cloaked Noblewoman",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Novice Witch":
			quest = createQuest(
		["Hi sweetie. Do you think you have a second to help me out?",
		"I was having problems making a " + randomPotion + ".",
		"Do you think I could buy one from you?"],									#allQueststartDialog
		["Hey there sweetheart, how have you been?",
		"By any chance is that " + randomPotion + " ready?"],										#QuestReturningDialog
		["Aw shucks, no worries sweetheart.",
		"I’ll just try again myself a few times."],							#QuestRejectedDialog
		["Aw, oh well. It’s probably better if I try to learn this myself."],							#QuestFailedDialog
		["Amazing work sweetie!",
		"This is so much better than what I’ve been making! Thank you so much!"],										#allQuestsuccses
		["I’ll be sure to swing by again to see your cute face and to grab some more potions."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Novice Witch",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Powerful Witch":
			quest = createQuest(
		["Hey there. I heard about this shop from some of my customers.",
		"They claim your potions are unparalleled.",
		"Let’s see what you can do.",
		"Do you think I can try your version of a " + randomPotion + "?"],									#allQueststartDialog
		["Well, do you have the " + randomPotion + " ready?"],										#QuestReturningDialog
		["Interesting. Maybe by unparalleled they mean nobody is this weak.",
		"Well. See you around."],							#QuestRejectedDialog
		["I find it unsurprising that a weak potion master like yourself cannot complete this task.",
		"Goodbye."],							#QuestFailedDialog
		["I see you are at least capable of this."],										#allQuestsuccses
		["I’ll be sure to swing by again to see your cute face and to grab some more potions."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		false,																#IsRepeatable
		"Powerful Witch",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Unfriendly Squire":
			quest = createQuest(
		["You.",
		"Do you have a " + randomPotion + "?"],									#allQueststartDialog
		["Do you have it now? The " + randomPotion + "?"],										#QuestReturningDialog
		["Great. Of course you don’t have it."],							#QuestRejectedDialog
		["I waited for nothing.",
		"I’That could have been easy money for you, but whatever.",
		"Bye."],							#QuestFailedDialog
		["That’s great. Thanks for getting this to me."],										#allQuestsuccses
		["I’ll be sure to stop by again, you’re a great potion master!"],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		false,																#IsRepeatable
		"Unfriendly Squire",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Vacant Mercenary":
			quest = createQuest(
		["Hey there, I was told to stop by here.",
		"My commander told me to get a grip and a " + randomPotion + "?",
		"By any chance do you got any of those?"],									#allQueststartDialog
		["Hi again. Sorry to bother you.",
		"My commander has really been bugging me about that potion.",
		"Do you have it in stock yet?"],										#QuestReturningDialog
		["Fair enough. See you around."],							#QuestRejectedDialog
		["Well, things could be worse.",
		"I don’t see why we needed it in the first place, just use your sword.",
		"You should get a sword.",
		"Bye."],							#QuestFailedDialog
		["Yes! Thank you so much.",
		"One thing my commander asked me for, finally."],										#allQuestsuccses
		["My commander seemed interested in sending me to get more potions,",
		"so I’ll probably see you again soon. See you."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Vacant Mercenary",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Wisened Dwarf":
			quest = createQuest(
		["Hello there young one.",
		"I come from the mountains across the sea in search of ancient relics.",
		"I am in need of a " + randomPotion + " for my quest.",
		"Do you think you can aid me on my journey?"],									#allQueststartDialog
		["Hello there child. Have you had time to create the " + randomPotion + "?"],										#QuestReturningDialog
		["You should never fear new things. I hope one day you are able to learn this recipe.",
		"That day I hope you can aid the next adventurer in my footsteps.",
		"Farewell and good luck."],							#QuestRejectedDialog
		["At least you have tried. Good luck with your endeavors and farewell child."],							#QuestFailedDialog
		["Thank you, I knew a skilled craftsman resided in this shop.",
		"I have quite an eye for these things."],										#allQuestsuccses
		["I’ll be sure to swing by again to see your cute face and to grab some more potions."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		false,																#IsRepeatable
		"Wisened Dwarf",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
		"Wobbly Cloaked Figure":
			quest = createQuest(
		["Quick! I need assistance!",
		"I am in urgent need of... uhh...", "*whispering*", "oh right, " + randomPotion + ".",
		"Do you have it?"],									#allQueststartDialog
		["Hi again, do you have " + randomPotion + " yet?"],										#QuestReturningDialog
		["Oh shoot. We heard such great things about this shop.",
		"Guess we’ll have to try somewhere else."],							#QuestRejectedDialog
		["I told you this shop wouldn’t have it. Why don’t you listen to me?",
		"it was worth a try..."],							#QuestFailedDialog
		["Sweet! Thanks a bunch!", "yea, thanks."],										#allQuestsuccses
		["When we make it back, we’ll be sure to stop by again.",
		"We as in my party. Yeah, my party."],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Wobbly Cloaked Figure",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
	
		"Frog Fanatic":
			quest = createQuest(
		["Hiya!", "Lovely shop you've got here.",
		"I passed it when traveling through the woods with my little friends",
		"Do you happen to have " + randomPotion],									#allQueststartDialog
		["Hiya!", "can you believe this weather we're having?",
		"Absolutely splendid!", "Anyways, do you have that potion ready?"],										#QuestReturningDialog
		["Oh, that's okay.", "We'll just hop around the woods to find the ingredients ourselves.",
		"Have a nice day."],							#QuestRejectedDialog
		["Ah well", "Days can't be perfect or the next one won't be as good in comparison",
		"Take care!"],							#QuestFailedDialog
		["Oh lovely!", "I'll have time for a bit of splashing around by the pond.",
		"I'll see you later"],										#allQuestsuccses
		["I hope we cross paths again, you and your shop are quite adorable!"],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Frog Fanatic",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
	
		"Carefree Blacksmith":
			quest = createQuest(
		["Hey there!", "I was just passin' by. I heard good things about the " + randomPotion,
		"Do you have one?"],									#allQueststartDialog
		["Hey there stranger!", "Do you have that " + randomPotion + " ready yet?"],										#QuestReturningDialog
		["Hey! No worries.", "If you get any adventurers in need of weapons, send them my way through."],							#QuestRejectedDialog
		["That's okay, it was nice chatting.", "See you."],							#QuestFailedDialog
		["Oh? This is so cool!", "I could never do this myself. Thanks!"],										#allQuestsuccses
		["Maybe I'll be able to stop by the shop again.", "See you around!"],		#Joining pharmacy dialog
		[],
		[randomPotion],																#Requirements
		69,																	#RewardMoney
		[randomRecipeReward],																	#RewardRecipes
		["earth"],												#RewardIngredients
		3,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Carefree Blacksmith",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	)
	
	# If npc not found
	if(quest == null):
		printerr("Could not find npc: ", npcName)
		
	return quest
