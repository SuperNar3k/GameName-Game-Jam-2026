extends Control
@onready var backRoomButton : Button = $goToBackroom

signal toBackRoom

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	backRoomButton.pressed.connect(_on_backRoomButton_pressed)

func _on_backRoomButton_pressed() -> void:
	toBackRoom.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
