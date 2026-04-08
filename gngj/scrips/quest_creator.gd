class_name Quest_Creator
extends Node

func createQuest(
	_questStartDialog: Variant,
	_questReturingDialog: Variant,
	_questRejectedDialog: Variant,
	_questFailedDialog: Variant,
	_questSuccsesDialog: Variant,
	_requirements: Variant,
	_rewardMoney: Variant,
	_rewardRecipes: Variant,
	_rewardIngredients: Variant,
	_daysUntilDue: Variant,
	_daysUntilReward: Variant,
	_isReapeatable: Variant,
	_npcNameOrType: String,
	_NPCBirthingPod: npc_birthing_pod
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
		_questStartDialog,
		_questReturingDialog,
		_questRejectedDialog,
		_questFailedDialog,
		_questSuccsesDialog,
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
