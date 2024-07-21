extends Control

@onready var controls_button = $CenterContainer/Panel/VBoxContainer/controls_button
@onready var music_toggle_button = $CenterContainer/Panel/VBoxContainer/music_toggle_button
@onready var tts_toggle_button = $CenterContainer/Panel/VBoxContainer/tts_toggle_button
@onready var choose_voice_dropdown = $CenterContainer/Panel/VBoxContainer/choose_voice_dropdown
@onready var font_color_picker_button = $CenterContainer/Panel/VBoxContainer/font_color_picker_button
@onready var font_size_dropdown = $CenterContainer/Panel/VBoxContainer/font_size_dropdown
@onready var back_button = $CenterContainer/Panel/VBoxContainer/back_button
@onready var title_label = $CenterContainer/Panel/VBoxContainer/title_label

func _ready():
	await get_tree().create_timer(0.1).timeout
	controls_button.grab_focus()  # Set initial focus to the first button
	_connect_buttons()
	_setup_layout()
	_populate_dropdowns()
	
func _connect_buttons():
	controls_button.connect("pressed", Callable(self, "_on_controls_button_pressed"))
	music_toggle_button.connect("pressed", Callable(self, "_on_music_toggle_button_pressed"))
	tts_toggle_button.connect("pressed", Callable(self, "_on_tts_toggle_button_pressed"))
	choose_voice_dropdown.connect("item_selected", Callable(self, "_on_choose_voice_dropdown_selected"))
	font_color_picker_button.connect("color_changed", Callable(self, "_on_font_color_picker_button_changed"))
	font_size_dropdown.connect("item_selected", Callable(self, "_on_font_size_dropdown_selected"))
	back_button.connect("pressed", Callable(self, "_on_back_button_pressed"))

func _setup_layout():
	$CenterContainer/Panel.custom_minimum_size = Vector2(400, 300) 
	for child in $CenterContainer/Panel/VBoxContainer.get_children():
		if child is Button or child is OptionButton or child is ColorPickerButton:
			child.custom_minimum_size = Vector2(350, 50) 
			child.custom_minimum_size = Vector2(350, 50)
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			child.size_flags_vertical = Control.SIZE_EXPAND_FILL

func _populate_dropdowns():
	var voices = DisplayServer.tts_get_voices_for_language("es")
	for voice in voices:
		choose_voice_dropdown.add_item(voice)
	
	for size in [10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30]:
		font_size_dropdown.add_item(str(size))

func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://scenes/input_options_menu.tscn")
	
func _on_music_toggle_button_pressed():
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")):
		music_toggle_button.text = "Habilitar musica"
	else:
		music_toggle_button.text = "Musica habilitada"
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), not AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")))

func _on_tts_toggle_button_pressed():
	if global.tts_enabled:
		tts_toggle_button.text = "TTS habilitado"
		global.tts_enabled = false
	else:
		tts_toggle_button.text = "Habilitar TTS"
		global.tts_enabled = true

func _on_choose_voice_dropdown_selected(index):
	global.voice_id = DisplayServer.tts_get_voices_for_language("es")[index]

func _on_font_color_picker_button_changed(color):
	global.font_color = color

func _on_font_size_dropdown_selected(index):
	global.font_size = font_size_dropdown.get_item_text(index).to_int()

func _on_back_button_pressed():
	var sceneRoute = "res://scenes/" + global.current_scene + ".tscn"
	get_tree().change_scene_to_file(sceneRoute)

