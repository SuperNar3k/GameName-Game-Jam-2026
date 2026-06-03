extends Control

func fadeIn() -> void:
	$ColorRect.show()
	$TransitionPlayer.play("fade_in")
	#await get_tree().create_timer(0.2).timeout

func fadeOut() -> void:
	$TransitionPlayer.play("fade_out")
	await get_tree().create_timer(0.2).timeout
	$ColorRect.hide()
