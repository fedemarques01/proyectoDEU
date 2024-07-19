extends CanvasLayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	$VBoxContainer/return_button.grab_focus()
	$VBoxContainer/return_button.connect("pressed", Callable(self, "_on_back_to_game_pressed"))
	$VBoxContainer/options_button.connect("pressed", Callable(self, "_on_options_button_pressed"))
	$VBoxContainer/map_button.connect("pressed", Callable(self, "_on_map_pressed"))
	$VBoxContainer/quit_button.connect("pressed", Callable(self, "_on_quit_button_pressed"))

func _on_back_to_game_button_pressed():
	print("Back to game pressed")
	hide()
	get_tree().paused = false

	
func _on_options_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_map_pressed():
	get_tree().paused = false
	pass

func _on_quit_button_pressed():
	hide()
	get_tree().paused = false
	
func show_menu():
	get_tree().paused = true
	show()
