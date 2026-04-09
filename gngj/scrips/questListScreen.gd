extends Control

@onready var returnButton : Button = $returnButton

signal returnToGame


var quest = preload("res://Scenes/displayQuestOnList.tscn").instantiate()

func displayShit(activeQuests : Array, pharmacyQuests : Array, allPotions: Dictionary):
	$ScrollContainer.scroll_vertical = 0
	
	for pQuest in pharmacyQuests: 
		$ScrollContainer/AspectRatioContainer/VBoxContainer/pharmacyLable.add_sibling(quest)
		quest.add_to_group("questToDelete")
		quest.setSprite(allPotions.values()[pQuest.requirements[0]].sprite)
		quest.setPotionName(allPotions.values()[pQuest.requirements[0]].itemName)
		quest.setNpcName(pQuest.npcQuestGiver.npcName)
		quest.setDaysUntilDue(pQuest.daysUntilDue)
		
		quest = preload("res://Scenes/displayQuestOnList.tscn").instantiate()
		
	for aQuest in activeQuests: 
		$ScrollContainer/AspectRatioContainer/VBoxContainer/questLable.add_sibling(quest)
		quest.add_to_group("questToDelete")
		quest.setSprite(allPotions.values()[aQuest.requirements[0]].sprite)
		quest.setPotionName(allPotions.values()[aQuest.requirements[0]].itemName)
		quest.setNpcName(aQuest.npcQuestGiver.npcName)
		quest.setDaysUntilDue(aQuest.daysUntilDue)
		
		quest = preload("res://Scenes/displayQuestOnList.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	returnButton.pressed.connect(_on_returnButton_pressed)
	
func _on_returnButton_pressed() -> void: 
	get_tree().call_group("questToDelete", "queue_free")
	returnToGame.emit()
