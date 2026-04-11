extends Control
@onready var backRoomButton : Button = $goToBackroom
@onready var npcButton : TextureButton = $NPC
@onready var acceptButton : Button = $acceptQuestButton
@onready var rejectButton : Button = $rejectQuestButton

signal toBackRoom
signal talkToNpc
signal questAccepted(option)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	backRoomButton.pressed.connect(_on_backRoomButton_pressed)
	npcButton.pressed.connect(_on_npcButton_pressed)
	acceptButton.pressed.connect(_on_questAccepted_pressed)
	rejectButton.pressed.connect(_on_questRejected_pressed)

func _on_backRoomButton_pressed() -> void:
	toBackRoom.emit()
	
func _on_npcButton_pressed():
	talkToNpc.emit()	
	
func _on_questAccepted_pressed():
	questAccepted.emit(true)

func _on_questRejected_pressed():
	questAccepted.emit(false)
