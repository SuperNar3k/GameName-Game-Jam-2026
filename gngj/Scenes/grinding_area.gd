extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Pestle"):
		print("Sheeesh!")


	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#print("hehe")
		#print("1")
