extends TextureButton

func _on_mouse_entered() -> void:
	material.set_shader_parameter("outline_thickness", 3.0)
	var randPitch = (randf_range(.8, 1.2))
	$AudioStreamPlayer2D.pitch_scale = randPitch
	$AudioStreamPlayer2D.play(.2)


func _on_mouse_exited() -> void:
	material.set_shader_parameter("outline_thickness", 0.0)
