extends Node
 
var current_scene = "entrada_facu"
var transition_scene = false
var transition_to = "entrada_facu"
var change_camera = false


# configs
const CONFIG_PATH: String = "user://settings.cfg"
var font_size: int = 14
var font_color: Color = Color.WHITE

#(311, 619) position default for "entrada_facu" start
var player_transition_posx = 311
var player_transition_posy = 619

# Velocidad del jugador
var initial_speed: float = 400.0
var SPEED: float = initial_speed

var pause_menu
# TTS variables
var TTS_ENABLED = false
var voices = DisplayServer.tts_get_voices_for_language("es")
var voice_id = voices[0]

func _ready():
	print("Global listo: TTS inicializado")
	var pause_menu_scene = preload("res://scenes/pause_menu.tscn")
	pause_menu = pause_menu_scene.instantiate()
	get_tree().root.call_deferred("add_child", pause_menu) 
	pause_menu.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	pause_menu.hide() 
	load_settings()

func get_speed() -> float:
	return SPEED
func set_speed(speed: float):
	SPEED = speed
	save_speed()
func reset_speed():
	SPEED = self.initial_speed

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_PATH)
	if err == OK:
		SPEED = config.get_value("player", "speed", initial_speed)
		TTS_ENABLED = config.get_value("settings", "tts_enabled", false)
	else:
		SPEED = initial_speed
		TTS_ENABLED = false

func save_speed():
	var config = ConfigFile.new()
	config.set_value("player", "speed", SPEED)
	config.save(CONFIG_PATH)

func set_tts_enabled(enabled: bool):
	TTS_ENABLED = enabled
	save_tts()

func get_tts_enabled() -> bool:
	return TTS_ENABLED

func save_tts():
	var config = ConfigFile.new()
	config.set_value("settings", "tts_enabled", TTS_ENABLED)
	config.save(CONFIG_PATH)
	
func speak(text: String):
	if get_tts_enabled():
		DisplayServer.tts_speak(text, voice_id)

func test_start():
	speak("Bienvenido a la entrada de la universidad")

func toggle_pause():
	if get_tree().paused:
		pause_menu.hide()
		get_tree().paused = false
	else:
		pause_menu.show()
		pause_menu.return_button.focus_mode = Control.FOCUS_ALL
		pause_menu.return_button.grab_focus()
		get_tree().paused = true
