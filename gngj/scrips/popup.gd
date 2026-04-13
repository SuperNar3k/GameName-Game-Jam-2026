extends Control

#globals
var sec = 5

var isPlaying = false
signal finishedPlaying


#Called when the node enters the scene tree for the first time.
func newItemUnlocked(item: Item, type: String):

	if(isPlaying):
		await finishedPlaying

	isPlaying = true
	$contName/nameLabel.set_text(item.itemName)
	$contTitle/titleLabel.set_text("New " + type + " Unlocked!")
	$itemSprite.set_texture(load(item.sprite))
	$popupTimer.start(sec)
	$".".show()
	$popupAnimation.play("moveIn")


func onTimerTimeout() -> void:
	$popupAnimation.play("moveOut")

func onPopupAnimationFinished(anim_name: StringName) -> void:
	if anim_name == "moveOut":
			$".".hide()
			isPlaying = false
			finishedPlaying.emit()
