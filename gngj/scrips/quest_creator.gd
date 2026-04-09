class_name Quest_Creator
extends Node

func createQuest(
	_allQueststartDialog: Variant,
	_questReturingDialog: Variant,
	_questRejectedDialog: Variant,
	_questFailedDialog: Variant,
	_allQuestsuccsesDialog: Variant,
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
	var _npc
	if _npcNameOrType == "Child":
		_npc = _NPCBirthingPod.GetRandomChild()
	elif _npcNameOrType == "Townsfolk":
		_npc = _NPCBirthingPod.GetRandomChild()
	elif _npcNameOrType == "Adventurer":
		_npc = _NPCBirthingPod.GetRandomChild()
	else:
		_npc = _NPCBirthingPod.BirthNPC(_npcNameOrType)
	
	var newQuest = Quest.new()
	newQuest.__init__(
		_allQueststartDialog,
		_questReturingDialog,
		_questRejectedDialog,
		_questFailedDialog,
		_allQuestsuccsesDialog,
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
	
func Populate(allQuests: Array, NPCBirthingPod: Npc_Birthing_Pod):
	#Hardcoding all of our allQuests here:
	allQuests.append(createQuest(
		["Hi, can you make me", "some cinnamon milk?"],						#allQueststartDialog
		["Ugh, you got that milk yet?"],									#QuestReturningDialog
		["Aw, that's okay bitch","I'll get my milk from somewhere else!"],	#QuestRejectedDialog
		["What a waste of my time", "I hope you get eaten by a dragon"],	#QuestFailedDialog
		["Oh my gosshhhh thank youuuuu!", "SLURP SLURP SLURP"],				#allQuestsuccses
		[0],																#Requirements
		69,																	#RewardMoney
		["epic fucking monkey"],											#RewardRecipes
		["beans", "asbestos"],												#RewardIngredients
		1,																	#DaysUntilDue
		0,																	#DaysUntilReward
		true,																#IsRepeatable
		"Brenna Tallowmere",												#NpcTypeOrName
		NPCBirthingPod														#Pass the birthing pod
	))
	
	allQuests.append(createQuest(
		["Adventurer! I require", "a vial of destiny!"],                    
		["Have you returned with the dew of destiny?"],                                 
		["A tragedy! A cosmic failure!","I shall seek another hero."],  
		["The stars weep for your incompetence."],  
		["Marvelous! The cosmos sings!","I can't wait to hear the music!"],              
		[0],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Adventurer",
		NPCBirthingPod
	))
	
	allQuests.append(createQuest(
		["Hi… um… can I buy a little Glow‑Up Potion?", "I wanna shine like the heroes!"],                    
		["Did you make my Glow‑Up Potion yet?"],                                 
		["Oh… okay…", "I guess I’ll stay normal today."],  
		["Aww… I really wanted to sparkle…"],  
		["YAY!! I’m gonna glow so bright!!", "SLURP!!"],              
		[0],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Child",
		NPCBirthingPod
	))

	allQuests.append(createQuest(
		["Hey there, I need a Potion of Relief.", "Long day… brain’s buzzing."],                    
		["Any chance that draught is ready?"],                                 
		["Well… that’s unfortunate.", "Guess I’ll stay stressed."],  
		["Great. Another day of headaches."],  
		["Oh thank the stars!", "My mind finally feels quiet."],              
		[0],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Townsfolk",
		NPCBirthingPod
	))

	allQuests.append(createQuest(
		["Potion‑maker!", "I require a Battle‑Fury Elixir before my next quest!"],                    
		["Surely the elixir is complete by now?"],                                 
		["Tch. Very well.", "I’ll fight without it."],  
		["A warrior denied their edge… disgraceful."],  
		["Excellent!", "The fury burns within me once more!"],              
		[0],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Adventurer",
		NPCBirthingPod
	))

	allQuests.append(createQuest(
		["Hi… can I get a dreamy sleep syrup?", "I keep having scary dreams…"],                    
		["Um… is my syrup done yet?"],                                 
		["Oh… okay…", "I guess I’ll try to sleep without it."],  
		["I hope the nightmares don’t come back…"],  
		["Yay!! I’ll sleep so good tonight!", "SLURP SLURP!"],              
		[0],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Child",
		NPCBirthingPod
	))

	allQuests.append(createQuest(
		["Hey… I need a Potion of Courage.", "There’s a rat in my basement and I’m terrified."],                    
		["Please tell me you’ve got that tonic ready…"],                                 
		["Of course not.", "Guess I’ll keep screaming at shadows."],  
		["Wonderful. Just wonderful."],  
		["YES! I feel brave already!", "Time to face that rat!"],              
		[0],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Townsfolk",
		NPCBirthingPod
	))

	allQuests.append(createQuest(
		["Potion‑seller!", "I need a Potion of Stoneskin before I face the ogres."],                    
		["Is the Potion of Stoneskin ready for battle?"],                                 
		["Hmph. Then my skin shall remain soft today."],  
		["A warrior without armor… pathetic."],  
		["Excellent!", "My body feels like granite!"],              
		[0],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Adventurer",
		NPCBirthingPod
	))

	allQuests.append(createQuest(
		["Hey there, I need a Potion of Luck.", "I’m gambling tonight and I need every edge."],                    
		["Any update on that tincture?"],                                 
		["Well, that’s my luck.", "Guess I’ll lose again."],  
		["Perfect. Just what I needed: more misfortune."],  
		["Yes! Tonight’s my night!", "Down the hatch!"],              
		[0],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Townsfolk",
		NPCBirthingPod
	))

	allQuests.append(createQuest(
		["Hi… can I get a potion to make me happy?", "It makes sad days feel better."],                    
		["Um… is my Happy‑Heart Potion done yet?"],                                 
		["Oh… okay…", "I’ll try to cheer up on my own."],  
		["I guess today stays gloomy…"],  
		["YAY!! My heart feels warm again!", "SLURP!"],              
		[0],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Child",
		NPCBirthingPod
	))
