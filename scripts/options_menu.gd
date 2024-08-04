extends Control

@onready var speed_slider = $CenterContainer/Panel/VBoxContainer/VBoxContainer2/VSplitContainer2/speed_slider
@onready var speed_label = $CenterContainer/Panel/VBoxContainer/VBoxContainer2/VSplitContainer2/speed_label
@onready var controls_button = $CenterContainer/Panel/VBoxContainer/controls_button
@onready var music_toggle_button = $CenterContainer/Panel/VBoxContainer/VBoxContainer/music_toggle_button
@onready var tts_toggle_button = $CenterContainer/Panel/VBoxContainer/VBoxContainer/tts_toggle_button
@onready var choose_voice_dropdown = $CenterContainer/Panel/VBoxContainer/VBoxContainer/choose_voice_dropdown
@onready var font_color_picker_button = $CenterContainer/Panel/VBoxContainer/VBoxContainer2/HSplitContainer2/font_color_picker_button
@onready var font_size_dropdown = $CenterContainer/Panel/VBoxContainer/VBoxContainer2/HSplitContainer/font_size_dropdown
@onready var back_button = $CenterContainer/Panel/VBoxContainer/back_button
@onready var title_label = $CenterContainer/Panel/VBoxContainer/title_label
@onready var volume_label = $CenterContainer/Panel/VBoxContainer/VBoxContainer/VSplitContainer/volume_label
@onready var volume_slider = $CenterContainer/Panel/VBoxContainer/VBoxContainer/VSplitContainer/volume_slider

func _ready():
	await get_tree().create_timer(0.1).timeout
	tts_toggle_button.grab_focus()  
	_setup_layout()
	_populate_dropdowns()
	_update_music_slider_status()
	speed_slider.value = global.get_speed()
	speed_slider.connect("value_changed", Callable(self, "_on_speed_slider_value_changed"))

func _on_speed_slider_value_changed(value):
	global.set_speed(value)
	
func _setup_layout():
	volume_slider.value = 20
	$CenterContainer/Panel.custom_minimum_size = Vector2(400, 300) 
	for child in $CenterContainer/Panel/VBoxContainer.get_children():
		if child is Button or child is OptionButton or child is ColorPickerButton:
			child.custom_minimum_size = Vector2(350, 50) 
			child.custom_minimum_size = Vector2(350, 50)
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			child.size_flags_vertical = Control.SIZE_EXPAND_FILL
	for child in $CenterContainer/Panel/VBoxContainer/VBoxContainer.get_children():
		if child is Button or child is OptionButton or child is ColorPickerButton:
			child.custom_minimum_size = Vector2(350, 50) 
			child.custom_minimum_size = Vector2(350, 50)
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			child.size_flags_vertical = Control.SIZE_EXPAND_FILL
	for child in $CenterContainer/Panel/VBoxContainer/VBoxContainer2/HSplitContainer.get_children():
		if child is Button or child is OptionButton or child is ColorPickerButton:
			child.custom_minimum_size = Vector2(350, 50) 
			child.custom_minimum_size = Vector2(350, 50)
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			child.size_flags_vertical = Control.SIZE_EXPAND_FILL
	for child in $CenterContainer/Panel/VBoxContainer/VBoxContainer2/HSplitContainer2.get_children():
		if child is Button or child is OptionButton or child is ColorPickerButton:
			child.custom_minimum_size = Vector2(350, 50) 
			child.custom_minimum_size = Vector2(350, 50)
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			child.size_flags_vertical = Control.SIZE_EXPAND_FILL

	var margin_container = $CenterContainer/Panel
	margin_container.set("custom_constants/margin_top", 20)
	margin_container.set("custom_constants/margin_bottom", 20)


func _populate_dropdowns():
	var voices = DisplayServer.tts_get_voices_for_language("es")
	for voice in voices:
		choose_voice_dropdown.add_item(voice)
	
	for size in [10, 12, 14, 16, 18]:
		font_size_dropdown.add_item(str(size))

func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://scenes/input_options_menu.tscn")
	
func _on_music_toggle_button_pressed():
	if MusicPlayer.is_music_playing():
		music_toggle_button.text = "Habilitar musica"
		MusicPlayer.stop_music()
		
	else:
		music_toggle_button.text = "Musica habilitada"
		MusicPlayer.play_music()


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
	
func _update_music_slider_status():
	volume_slider.editable = MusicPlayer.is_music_playing()
	
func _on_volume_slider_value_changed(value):
	var db = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(0, db)

func linear_to_db(linear):
	if linear == 0:
		return -80 
	return 20 * log(linear)
	
func _process(delta):
	_update_music_slider_status()
