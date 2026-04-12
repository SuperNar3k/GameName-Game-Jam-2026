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
	
func Populate(allQuests: Array, NPCBirthingPod: Npc_Birthing_Pod):
	#Hardcoding all of our allQuests here:
	allQuests.append(createQuest(
		["Hi, can you make me", "some cinnamon milk?"],												#allQueststartDialog
		["Ugh, you got that milk yet?"],															#QuestReturningDialog
		["Aw, that's okay bitch","I'll get my milk from somewhere else!"],							#QuestRejectedDialog
		["What a waste of my time", "I hope you get eaten by a dragon"],							#QuestFailedDialog
		["Oh my gosshhhh thank youuuuu!", "SLURP SLURP SLURP"],										#allQuestsuccses
		["You seem to know what you're doing!","I'll keep coming back everyday for some milk!"],	#Joining pharmacy dialog
		[],
		["cinnamon toast crunch milk"],																#Requirements
		69,																	#RewardMoney
		["epic fucking monkey"],																	#RewardRecipes
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
		[],
		["Your milk was great!", "I was able to beat some monsters that I couldn't beat previously","Here's some extra loot for you!"],
		["cinnamon toast crunch milk"],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		1,                                                                  
		false,                                                               
		"Adventurer",
		NPCBirthingPod
	))
	
	allQuests.append(createQuest(
		["Hi… um… can I buy a little Glow‑Up Potion?", "I wanna shine like the heroes!"],                    
		["Did you make my Glow‑Up Potion yet?"],                                 
		["Oh… okay…", "I guess I’ll stay normal today."],  
		["Aww… I really wanted to sparkle…"],  
		["YAY!! I’m gonna glow so bright!!", "SLURP!!"],      
		["I'll be back everyday!"],
		[],        
		["cinnamon toast crunch milk"],                                                                
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
		[],
		["Your milk was great!", "I was able to beat some monsters that I couldn't beat previously","Here's some extra loot for you!"],           
		["epic fucking monkey"],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		1,                                                                  
		false,                                                               
		"Townsfolk",
		NPCBirthingPod
	))

	allQuests.append(createQuest(
		["Potion‑maker!", "I require a Battle‑Fury Elixir before my next quest!"],                    
		["Surely the elixir is complete by now?"],                                 
		["Tch. Very well.", "I’ll fight without it."],  
		["A warrior denied their edge… disgraceful."],  
		["Excellent!", "The fury burns within me once more!"],
		["I'll come every 2 days for another potion!"],
		[],              
		["epic fucking monkey"],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		2,                                                                  
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
		[],
		["Your milk was great!", "I was able to beat some monsters that I couldn't beat previously","Here's some extra loot for you!"],           
		["epic fucking monkey"],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		1,                                                                  
		false,                                                               
		"Child",
		NPCBirthingPod
	))

	allQuests.append(createQuest(
		["Hey… I need a Potion of Courage.", "There’s a rat in my basement and I’m terrified."],                    
		["Please tell me you’ve got that tonic ready…"],                                 
		["Of course not.", "Guess I’ll keep screaming at shadows."],  
		["Wonderful. Just wonderful."],  
		["YES! I feel brave already!", "Time to face that rat!"],
		["I have more rats", "so I think I'll come back everyday for another"],
		[],              
		["epic fucking monkey"],                                                                
		69,
		["epic fucking monkey"],
		["beans", "asbestos"],
		1,                                                                  
		0,                                                                  
		true,                                                               
		"Townsfolk",
		NPCBirthingPod
	))

	

	
