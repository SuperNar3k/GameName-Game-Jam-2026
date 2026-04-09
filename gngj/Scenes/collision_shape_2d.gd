extends CollisionShape2D

#func _process(delta: float) -> void:
	

func _on_body_entered(CollisionShape2D):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		print("hehe")
		print("1")
