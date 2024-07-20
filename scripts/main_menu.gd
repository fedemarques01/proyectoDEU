extends Control

func _ready():
	$VBoxContainer/start_button.grab_focus()

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

