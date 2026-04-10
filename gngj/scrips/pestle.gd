extends CharacterBody2D

var grabbed : bool = false

func _process(delta):
	if grabbed:
		var mouse_pos = get_global_mouse_position()
		global_position = lerp(global_position,mouse_pos,0.2)
		return
		
	
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == (MOUSE_BUTTON_LEFT):
		if event.pressed:
			grabbed = true
		else:
			grabbed = false
			position = $Marker2D.position
			
#func _on_body_entered():
	#if body.is_in_group("GrindingArea"):
		#print("Grinding")
	
