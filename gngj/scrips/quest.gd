class_name Quest
extends Node

#GLOBAL VARIABLES

var accepted = false
var questCompleted = false

var questDialog = [[],[],[],[],[]]
var requirements = []
var rewards = [[],[],[]]
var daysUntilDue
var daysUntilReward
var isRepeatable
var NPC = npc.new()

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
	_isReapeatable: Variant
):
	#Creating the dialog[][]
	for dialog in _questStartDialog:
		questDialog[0].append(dialog)
	for dialog in _questReturingDialog:
		questDialog[1].append(dialog)
	for dialog in _questRejectedDialog:
		questDialog[2].append(dialog)
	for dialog in _questFailedDialog:
		questDialog[3].append(dialog)
	for dialog in _questSuccsesDialog:
		questDialog[4].append(dialog)

	#Filling in the requirements[]
	for requirement in _requirements:
		requirements.append(requirement)

	#Creating the rewards[][]
	rewards[0].append(_rewardMoney)
	for recipe in _rewardRecipes:
		rewards[1].append(recipe)
	for ingredient in _rewardIngredients:
		rewards[2].append(ingredient)
	
	daysUntilDue = _daysUntilDue
	daysUntilReward = _daysUntilReward
	isRepeatable = _isReapeatable


#Fucntion for setting a random npc. Will choose a random name and sprite. Handled by npc class
func setNPC(index: Variant): 
	NPC.setRandNPC()







# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
