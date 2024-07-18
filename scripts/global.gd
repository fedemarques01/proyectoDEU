extends Node
 
var current_scene = "entrada_facu"
var transition_scene = false
var transition_to = "entrada_facu"
var change_camera = false

#(311, 619) position default for "entrada_facu" start
var player_transition_posx = 311
var player_transition_posy = 619


# TTS variables
var tts_enabled = true
var voices = DisplayServer.tts_get_voices_for_language("es")
var voice_id = voices[0]

func _ready():
	print("Global listo: TTS inicializado")


func speak(text: String):
	if tts_enabled:
		DisplayServer.tts_speak(text, voice_id)

func test_start():
	speak("Bienvenido a la entrada de la universidad")
