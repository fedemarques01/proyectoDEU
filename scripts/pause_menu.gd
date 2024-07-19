extends CanvasLayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	$VBoxContainer/return_button.grab_focus()

func _on_return_button_pressed():
	print("Back to game pressed")
	hide()
	get_tree().paused = false

	
func _on_options_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_map_button_pressed():
	print("Mostrar un mapa de la facu")
	pass

func _on_quit_button_pressed():
	get_tree().quit()
	
func show_menu():
	get_tree().paused = true
	show()


