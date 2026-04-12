extends Control
@onready var backRoomButton : Button = $goToBackroom
@onready var npcButton : TextureButton = $NPC
@onready var acceptButton : Button = $acceptQuestButton
@onready var rejectButton : Button = $rejectQuestButton

signal toBackRoom
signal talkToNpc
signal questAccepted(option)

var potionForQuest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	backRoomButton.pressed.connect(_on_backRoomButton_pressed)
	npcButton.pressed.connect(_on_npcButton_pressed)
	acceptButton.pressed.connect(_on_questAccepted_pressed)
	rejectButton.pressed.connect(_on_questRejected_pressed)

func displayPotionsInInventory(potions: Variant, keyPotion: Variant):
	var potionButton = preload("res://Scenes/PotionTexture.tscn").instantiate()
	potionForQuest = keyPotion
	
	for potion in potions: 
		if(potion.amountOwned > 0 and potion.unlocked):
			$potionHotbar/HBoxContainer.add_child(potionButton)
			potionButton.set_texture_normal(load(potion.sprite))
			potionButton.pressed.connect(isCorrectPotion.bind(potion))
			potionButton.add_to_group("buttonToDelete")
		
			potionButton = preload("res://Scenes/PotionTexture.tscn").instantiate()

func isCorrectPotion(selectedPotion: Variant):
	
	if(selectedPotion == potionForQuest):
		$givePotionButton.show()
	else: 
		$givePotionButton.hide()

func clearInventory():
	get_tree().call_group("buttonToDelete","queue_free")
	
func _on_backRoomButton_pressed() -> void:
	toBackRoom.emit()
	
func _on_npcButton_pressed():
	talkToNpc.emit()	
	
func _on_questAccepted_pressed():
	questAccepted.emit(true)

func _on_questRejected_pressed():
	questAccepted.emit(false)
