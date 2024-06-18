extends Control

func _ready():
	$VBoxContainer/start_button.grab_focus()
	$VBoxContainer/start_button.connect("pressed", Callable(self, "_on_start_button_pressed"))
	$VBoxContainer/options_button.connect("pressed", Callable(self, "_on_options_button_pressed"))
	$VBoxContainer/tutorial_button.connect("pressed", Callable(self, "_on_tutorial_button_pressed"))
	$VBoxContainer/quit_button.connect("pressed", Callable(self, "_on_quit_button_pressed"))

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/entrada_facu.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/input_options_menu.tscn")

func _on_tutorial_button_pressed():
	pass

func _on_quit_button_pressed():
	get_tree().quit()

