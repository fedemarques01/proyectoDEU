extends Node
 
var current_scene = "entrada_facu"
var transition_scene = false
var transition_to = "entrada_facu"
var change_camera = false

var font_size: int = 14
var font_color: Color = Color.WHITE

#(311, 619) position default for "entrada_facu" start
var player_transition_posx = 311
var player_transition_posy = 619
var SPEED = 400.0

var pause_menu
# TTS variables
var tts_enabled = false
var voices = DisplayServer.tts_get_voices_for_language("es")
var voice_id = voices[0]

func _ready():
	print("Global listo: TTS inicializado")
	var pause_menu_scene = preload("res://scenes/pause_menu.tscn")
	pause_menu = pause_menu_scene.instantiate()
	get_tree().root.call_deferred("add_child", pause_menu) 
	pause_menu.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	pause_menu.hide() 

func get_speed():
	return SPEED
func set_speed(speed):
	SPEED = speed

func speak(text: String):
	if tts_enabled:
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
