extends Button

@onready var tooltip = $Tooltip

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	
func on_mouse_entered():
	tooltip.toggle(false)

func on_mouse_exited():
	tooltip.toggle(true)
	
