extends Sprite2D



func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	global_position = mouse_pos
