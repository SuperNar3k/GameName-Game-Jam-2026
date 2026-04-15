extends Control

@onready var backButton : Button = $Back
@onready var mainMenuButton : Button = $MainMenu
signal backFromOptions
signal backToMainMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Controls.hide()
	$Sound/MasterVolumeSlider.value = SettingsManager.settings.master_volume
	$Sound/MasterVolumeSlider/MasterLabel.text = "%d%%" % int(round(SettingsManager.settings.master_volume * 100))
	$Sound/MusicVolumeSlider.value = SettingsManager.settings.music_volume
	$Sound/MusicVolumeSlider/MusicLabel.text = "%d%%" % int(round(SettingsManager.settings.music_volume * 100))
	$Sound/SFXVolumeSlider.value = SettingsManager.settings.sfx_volume
	$Sound/SFXVolumeSlider/Label.text = "%d%%" % int(round(SettingsManager.settings.sfx_volume * 100))
	
	

func _on_backButton_pressed() -> void: 
	print("backButtonPressed")
	backFromOptions.emit()

func _on_mainMenuButton_pressed() -> void: 
	print("mainmenuButtonPressed")
	backToMainMenu.emit()
	
#Change master volume
func _on_master_value_changed(value: float):
	$Sound/MasterVolumeSlider/MasterLabel.text = "%d%%" % int(round(SettingsManager.settings.master_volume * 100))
	SettingsManager.settings.master_volume = value
	SettingsManager.apply_all() 
	SettingsManager.save_settings()
	
#Change music volume
func _on_music_value_changed(value: float):
	$Sound/MusicVolumeSlider/MusicLabel.text = "%d%%" % int(round(SettingsManager.settings.music_volume * 100))
	SettingsManager.settings.music_volume = value
	SettingsManager.apply_all()
	SettingsManager.save_settings()
	
#Change sfx volume	
func _on_sfx_volume_value_changed(value: float) -> void:
	$Sound/SFXVolumeSlider/Label.text = "%d%%" % int(round(SettingsManager.settings.sfx_volume * 100)) 
	SettingsManager.settings.sfx_volume = value
	SettingsManager.apply_all() 
	SettingsManager.save_settings()

#Mute master volume
func _on_master_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)
#Mute music volume
func _on_music_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), toggled_on)
#Mute sfx volume
func _on_sfx_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), toggled_on)


func _on_open_sound_pressed() -> void:
	$Controls.hide()
	$Sound.show()


func _on_open_controls_pressed() -> void:
	$Sound.hide()
	$Controls.show()
