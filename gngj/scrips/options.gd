extends Control

@onready var backButton : Button = $Back
@onready var mainMenuButton : Button = $MainMenu
signal backFromOptions
signal backToMainMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	backButton.pressed.connect(_on_backButton_pressed)
	mainMenuButton.pressed.connect(_on_mainMenuButton_pressed)
	$TabContainer/Display/Resolutions.disabled = !SettingsManager.settings.windowed
	$TabContainer/Sound/MasterVolumeSlider.value = SettingsManager.settings.master_volume
	$TabContainer/Sound/MasterVolumeSlider/MasterLabel.text = "%d%%" % int(round(SettingsManager.settings.master_volume * 100))
	$TabContainer/Sound/MusicVolumeSlider.value = SettingsManager.settings.music_volume
	$TabContainer/Sound/MusicVolumeSlider/MusicLabel.text = "%d%%" % int(round(SettingsManager.settings.music_volume * 100))
	$TabContainer/Sound/SFXVolumeSlider.value = SettingsManager.settings.sfx_volume
	$TabContainer/Sound/SFXVolumeSlider/Label.text = "%d%%" % int(round(SettingsManager.settings.sfx_volume * 100))
	
	

func _on_backButton_pressed() -> void: 
	print("backButtonPressed")
	backFromOptions.emit()

func _on_mainMenuButton_pressed() -> void: 
	print("mainmenuButtonPressed")
	backToMainMenu.emit()
	
#Change master volume
func _on_master_value_changed(value: float):
	$TabContainer/Sound/MasterVolumeSlider/MasterLabel.text = "%d%%" % int(round(SettingsManager.settings.master_volume * 100))
	SettingsManager.settings.master_volume = value
	SettingsManager.apply_all() 
	SettingsManager.save_settings()
	
#Change music volume
func _on_music_value_changed(value: float):
	$TabContainer/Sound/MusicVolumeSlider/MusicLabel.text = "%d%%" % int(round(SettingsManager.settings.music_volume * 100))
	SettingsManager.settings.music_volume = value
	SettingsManager.apply_all()
	SettingsManager.save_settings()
	
#Change sfx volume	
func _on_sfx_volume_value_changed(value: float) -> void:
	$TabContainer/Sound/SFXVolumeSlider/Label.text = "%d%%" % int(round(SettingsManager.settings.sfx_volume * 100)) 
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
	SettingsManager.settings.windowed = toggled_on 
	$TabContainer/Display/Resolutions.disabled = !SettingsManager.settings.windowed
	SettingsManager.apply_all()
	SettingsManager.save_settings()
