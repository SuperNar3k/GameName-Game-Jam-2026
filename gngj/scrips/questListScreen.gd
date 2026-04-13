extends Control

@onready var returnButton : Button = $returnButton

signal returnToGame


var quest = preload("res://Scenes/displayQuestOnList.tscn").instantiate()

func displayShit(activeQuests : Array, pharmacyQuests : Array, allPotions: Dictionary):
	$ScrollContainer.scroll_vertical = 0
	
	for pQuest in pharmacyQuests: 
		$ScrollContainer/AspectRatioContainer/VBoxContainer/pharmacyLable.add_sibling(quest)
		quest.add_to_group("questToDelete")
		quest.setSprite(allPotions.get(pQuest.requirements[0]).sprite)
		quest.setPotionName(allPotions.get(pQuest.requirements[0]).itemName)
		quest.setNpcName(pQuest.npcQuestGiver.npcName)
		quest.setDaysUntilDue(pQuest.daysUntilDue)
		
		quest = preload("res://Scenes/displayQuestOnList.tscn").instantiate()
		
	for aQuest in activeQuests: 
		if (!aQuest.completed):
			$ScrollContainer/AspectRatioContainer/VBoxContainer/questLable.add_sibling(quest)
			quest.add_to_group("questToDelete")
			quest.setSprite(allPotions.get(aQuest.requirements[0]).sprite)
			quest.setPotionName(allPotions.get(aQuest.requirements[0]).itemName)
			quest.setNpcName(aQuest.npcQuestGiver.npcName)
			quest.setDaysUntilDue(aQuest.daysUntilDue)
		
			quest = preload("res://Scenes/displayQuestOnList.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	returnButton.mouse_entered.connect(_on_hovered.bind(true))
	returnButton.mouse_exited.connect(_on_hovered.bind(false))
	returnButton.pressed.connect(_on_returnButton_pressed)
	
func _on_hovered(hovered):
	$Sprite2D2.material.set_shader_parameter("outline_thickness", 5.0 if hovered else 0.0)

func _on_returnButton_pressed() -> void: 
	get_tree().call_group("questToDelete", "queue_free")
	returnToGame.emit()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if $ColorRect.color.a > 0:
		$returnButton.show()
		$Sprite2D2.show()
	else:
		$ColorRect.hide()
