extends Sprite2D



func _process(_delta):
		
	var x
	var y
	if(get_global_mouse_position().x + $Label.size.x > 1890):
		x = 1890 - $Label.size.x
	else: 
		x = get_global_mouse_position().x
		
	if((get_global_mouse_position().y - 100) < 150):
		y = 150
	else: 
		y = get_global_mouse_position().y - 100
	
	
	global_position = get_global_mouse_position()
	$Label.global_position = Vector2(x, y)
