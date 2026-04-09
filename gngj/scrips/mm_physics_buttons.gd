extends Node2D

func _ready() -> void:
	$open/openbtn.mouse_entered.connect(got_hovered.bind("open", true))
	$open/openbtn.mouse_exited.connect(got_hovered.bind("open", false))
	$options/optionsbtn.mouse_entered.connect(got_hovered.bind("options", true))
	$options/optionsbtn.mouse_exited.connect(got_hovered.bind("options", false))
	$credits/creditsbtn.mouse_entered.connect(got_hovered.bind("credits", true))
	$credits/creditsbtn.mouse_exited.connect(got_hovered.bind("credits", false))
	$close/closebtn.mouse_entered.connect(got_hovered.bind("close", true))
	$close/closebtn.mouse_exited.connect(got_hovered.bind("close", false))

func _physics_process(delta: float) -> void:
	$follower.global_position = get_global_mouse_position()


func _on_area_2d_body_entered(body: RigidBody2D) -> void:
	if $collisionTimer.is_stopped():
		$collisionTimer.start(.2)


func _on_collision_timer_timeout() -> void:
	if $follower/CollisionShape2D.disabled:
		if $follower/Area2D.has_overlapping_bodies():
			$collisionTimer.start(1)
			print("hello")
		else:
			$follower/CollisionShape2D.set_deferred("disabled", false)
	else:
		$collisionTimer.start(1)
		$follower/CollisionShape2D.set_deferred("disabled", true)
		

func got_hovered(btn: String, hovered: bool):
	if btn == "open":
		$open/openimg.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
	if btn == "options":
		$options/optionsimg.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
	if btn == "credits":
		$credits/creditsimg.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
	if btn == "close":
		$close/closeimg.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
