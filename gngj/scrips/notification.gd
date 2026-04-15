extends Control

signal finishedPlaying



func _on_popup_finished_playing() -> void:
	finishedPlaying.emit()
