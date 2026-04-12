extends TextureButton

func _on_mouse_entered() -> void:
	material.set_shader_parameter("outline_thickness", 3.0)


func _on_mouse_exited() -> void:
	material.set_shader_parameter("outline_thickness", 0.0)
