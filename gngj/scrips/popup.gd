extends Control

#globals
var sec = 3
signal finishedPlaying

#Called when the node enters the scene tree for the first time.
func newItemUnlocked(item: Item, type: String):

	$AudioStreamPlayer2D.play(.11)
	$contName/nameLabel.set_text(item.itemName)
	$contTitle/titleLabel.set_text("New " + type + " Unlocked!")
	$itemSprite.set_texture(load(item.sprite))
	$popupTimer.start(sec)
	$".".show()
	$popupAnimation.play("moveIn")

func itemMade(item: Item, type : String):
	
	$AudioStreamPlayer2D.play(.11)
	$contTitle/titleLabel.set_text(type + " Created!")
	$contName/nameLabel.set_text(item.itemName)
	$itemSprite.set_texture(load(item.sprite))
	$popupTimer.start(sec)
	$".".show()
	$popupAnimation.play("moveIn")

func onTimerTimeout() -> void:
	$popupAnimation.play("moveOut")
	

func onPopupAnimationFinished(anim_name: StringName) -> void:
	if anim_name == "moveOut":
		$".".hide()
		finishedPlaying.emit()
