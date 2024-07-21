extends CanvasLayer

@onready var return_button = $VBoxContainer/return_button
@onready var map_button = $VBoxContainer/map_button
@onready var options_button = $VBoxContainer/options_button
@onready var quit_button = $VBoxContainer/quit_button

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	_connect_buttons()
	await get_tree().create_timer(0.1).timeout
	return_button.grab_focus()
	_resize_buttons()

	

func _resize_buttons():
	$VBoxContainer.custom_minimum_size = Vector2(300, 400)
	$VBoxContainer/return_button.custom_minimum_size = Vector2(200, 50)
	$VBoxContainer/options_button.custom_minimum_size = Vector2(200, 50)
	$VBoxContainer/map_button.custom_minimum_size = Vector2(200, 50)
	$VBoxContainer/quit_button.custom_minimum_size = Vector2(200, 50)
	
func _connect_buttons():
	return_button.connect("pressed", Callable(self, "_on_return_button_pressed"))
	map_button.connect("pressed", Callable(self, "_on_map_button_pressed"))
	options_button.connect("pressed", Callable(self, "_on_options_button_pressed"))
	quit_button.connect("pressed", Callable(self, "_on_quit_button_pressed"))
	
func _on_return_button_pressed():
	print("Back to game pressed")
	get_tree().paused = false
	hide()

	
func _on_options_button_pressed():
	get_tree().paused = false
	hide()
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_map_button_pressed():
	print("Mostrar un mapa de la facu")
	hide()
	pass

func _on_quit_button_pressed():
	get_tree().quit()
	
func show_menu():
	get_tree().paused = true
	show()


