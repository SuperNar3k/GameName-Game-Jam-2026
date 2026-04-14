extends CharacterBody2D

var grabbed : bool = false
var home_pos

func _process(delta):
	if grabbed:
		var mouse_pos = get_global_mouse_position()
		global_position = lerp(global_position,mouse_pos,0.2)
		return
		
	
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == (MOUSE_BUTTON_LEFT):
		
			
#func _on_body_entered():
	#if body.is_in_group("GrindingArea"):
		#print("Grinding")
	


func _ready() -> void:
	home_pos = position



func _on_pick_up_button_down() -> void:
	if grabbed == false:
		grabbed = true



func _on_pick_up_button_up() -> void:
	if grabbed == true:
		position = home_pos
		grabbed = false
