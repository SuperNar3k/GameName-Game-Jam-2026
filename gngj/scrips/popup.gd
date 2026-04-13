extends Control

#globals
var sec = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_button_pressed() -> void:
	$contName/nameLabel.set_text("Crushed Asbestos")
	$contTitle/titleLabel.set_text("New " + "Ingred/Recipe" + " Unlocked!")
	$popupTimer.start(sec)
	$".".show()
	$popupAnimation.play("moveIn")

func onTimerTimeout() -> void:
	$popupAnimation.play("moveOut")

func onPopupAnimationFinished(anim_name: StringName) -> void:
	if anim_name == "moveOut":
			$".".hide()
