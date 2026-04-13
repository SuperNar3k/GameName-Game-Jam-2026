extends Node
#Setting variables to be called by the game
var settings = {
	"master_volume": 1.0,
	"music_volume": 1.0,
	"sfx_volume": 1.0,
	"windowed": false,
	"resolution": Vector2i(1920,1080)
}

#On start loads last saved settings
func _ready() -> void:
	load_settings()
	apply_all()

#Appliess current settings
func apply_all():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(settings.master_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(settings.music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(settings.sfx_volume))
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if settings.windowed else DisplayServer.WINDOW_MODE_FULLSCREEN)
	DisplayServer.window_set_size(settings.resolution)

#Saves settings
func save_settings():
	var config = ConfigFile.new()
	for key in settings:
		config.set_value("settings", key, settings[key]) 
	config.save("user://settings.cfg")

#Loads current settings
func load_settings():
	var config = ConfigFile.new()
	if config.load("user://setings.cfg") == OK: 
		for key in settings:
			settings[key] = config.get_value("settings", key, settings[key])
