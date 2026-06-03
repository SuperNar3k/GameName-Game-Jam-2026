extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func playAnimation(animation : String):
	
	
	match animation: 
		"pointUp":
			var a = $AnimationPlayer.get_animation("pointUp")
			a.track_set_key_value(0, 0, position)
			a.track_set_key_value(0, 1, Vector2(position.x, position.y + 100))
			a.track_set_key_value(0, 2, position)
			$AnimationPlayer.play("pointUp")
			
		"pointUp2":
			var a = $AnimationPlayer.get_animation("pointUp2")
			a.track_set_key_value(0, 0, position)
			a.track_set_key_value(0, 1, Vector2(position.x, position.y + 100))
			a.track_set_key_value(0, 2, position)
			$AnimationPlayer.play("pointUp2")
			
		"pointUp3":
			var a = $AnimationPlayer.get_animation("pointUp3")
			a.track_set_key_value(0, 0, position)
			a.track_set_key_value(0, 1, Vector2(position.x, position.y + 100))
			a.track_set_key_value(0, 2, position)
			$AnimationPlayer.play("pointUp3")
			
		"pointUp4":
			var a = $AnimationPlayer.get_animation("pointUp4")
			a.track_set_key_value(0, 0, position)
			a.track_set_key_value(0, 1, Vector2(position.x, position.y + 100))
			a.track_set_key_value(0, 2, position)
			$AnimationPlayer.play("pointUp4")
			
		"pointRight":
			var a = $AnimationPlayer.get_animation("pointRight")
			a.track_set_key_value(0, 0, position)
			a.track_set_key_value(0, 1, Vector2(position.x + 100, position.y))
			a.track_set_key_value(0, 2, position)
			$AnimationPlayer.play("pointRight")
