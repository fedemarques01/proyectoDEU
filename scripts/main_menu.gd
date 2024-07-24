extends Control
@onready var start_button = %start_button
@onready var tutorial_button = $VBoxContainer/tutorial_button
@onready var options_button = $VBoxContainer/options_button
@onready var quit_button = $VBoxContainer/quit_button

func _ready():
	var button = $VBoxContainer/start_button
	await get_tree().create_timer(0.1).timeout
	button.grab_focus()
	resize_buttons()

func resize_buttons():
	$VBoxContainer.custom_minimum_size = Vector2(300, 400)
	start_button.custom_minimum_size = Vector2(200, 50)
	options_button.custom_minimum_size = Vector2(200, 50)
	tutorial_button.custom_minimum_size = Vector2(200, 50)
	quit_button.custom_minimum_size = Vector2(200, 50)

	
func _on_start_button_pressed():
	global.current_scene = "entrada_facu"
	get_tree().change_scene_to_file("res://scenes/entrada_facu.tscn")

func _on_options_button_pressed():
	global.current_scene = "main_menu"
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_tutorial_button_pressed():
	pass

func _on_quit_button_pressed():
	get_tree().quit()
	

