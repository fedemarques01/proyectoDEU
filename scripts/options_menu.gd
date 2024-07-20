extends Control

@onready var controls_button = $Panel/VBoxContainer/controls_button
@onready var music_toggle_button = $Panel/VBoxContainer/music_toggle_button
@onready var tts_toggle_button = $Panel/VBoxContainer/tts_toggle_button
@onready var choose_voice_button = $Panel/VBoxContainer/choose_voice_button
@onready var font_color_picker_button = $Panel/VBoxContainer/font_color_picker_button
@onready var font_size_button = $Panel/VBoxContainer/font_size_button
@onready var back_button = $Panel/VBoxContainer/back_button

func _ready():
	#_print_nodes()
	#_connect_buttons()
	pass

func _print_nodes():
	print("controls_button: ", controls_button)
	print("music_toggle_button: ", music_toggle_button)
	print("tts_toggle_button: ", tts_toggle_button)
	print("choose_voice_button: ", choose_voice_button)
	print("font_color_picker_button: ", font_color_picker_button)
	print("font_size_button: ", font_size_button)
	print("back_button: ", back_button)
	
func _connect_buttons():
	controls_button.connect("pressed", Callable(self, "_on_controls_button_pressed"))
	music_toggle_button.connect("pressed", Callable(self, "_on_music_toggle_button_pressed"))
	tts_toggle_button.connect("pressed", Callable(self, "_on_tts_toggle_button_pressed"))
	choose_voice_button.connect("pressed", Callable(self, "_on_choose_voice_button_pressed"))
	font_color_picker_button.connect("pressed", Callable(self, "_on_font_color_picker_button_pressed"))
	font_size_button.connect("pressed", Callable(self, "_on_font_size_button_pressed"))
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))

func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://scenes/input_options_menu.tscn")
	
func _on_music_toggle_button_pressed():
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")):
		music_toggle_button.text = "Enable Music"
	else:
		music_toggle_button.text = "Disable Music"
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), not AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")))

func _on_tts_toggle_button_pressed():
	global.tts_enabled = not global.tts_enabled

func _on_choose_voice_button_pressed():
	pass

func _on_font_color_picker_button_pressed():
	pass

func _on_font_size_button_pressed():
	pass

func _on_back_button_pressed():
	var sceneRoute = "res://scenes/" + global.current_scene + ".tscn"
	get_tree().change_scene_to_file(sceneRoute)
