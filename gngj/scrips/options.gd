extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TabContainer/Sound/MasterVolumeSlider.value = SettingsManager.settings.master_volume
	$TabContainer/Sound/MasterVolumeSlider/Label.text = "%d%%" % int(round(SettingsManager.settings.master_volume * 100))

#Change master volume
func _on_master_value_changed(value: float):
	SettingsManager.settings.master_volume = value
	$TabContainer/Sound/MasterVolumeSlider/Label.text = "%d%%" % int(round(SettingsManager.settings.master_volume * 100))
	SettingsManager.apply_all() 
	SettingsManager.save_settings()

#Change resolution of the game
func _on_resolutions_item_selected(index: int):
	match index:
		0:
			SettingsManager.settings.resolution = Vector2i(1920,1080)
			SettingsManager.apply_all() 
			SettingsManager.save_settings() 
		1:
			SettingsManager.settings.resolution = Vector2i(1600,900)
			SettingsManager.apply_all() 
			SettingsManager.save_settings()  
			
		2:
			SettingsManager.settings.resolution = Vector2i(1280,720)
			SettingsManager.apply_all() 
			SettingsManager.save_settings() 


func _on_full_screen_toggled(toggled_on: bool) -> void:
	SettingsManager.settings.fullscreen = toggled_on 
	SettingsManager.apply_all()
	SettingsManager.save_settings()


func _on_master_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
