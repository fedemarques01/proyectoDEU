extends Control

@onready var action_list = $Panel/MarginContainer/VBoxContainer/action_list

@onready var input_button1 = $Panel/MarginContainer/VBoxContainer/action_list/input_button1
@onready var input_button2 = $Panel/MarginContainer/VBoxContainer/action_list/input_button2
@onready var input_button3 = $Panel/MarginContainer/VBoxContainer/action_list/input_button3
@onready var input_button4 = $Panel/MarginContainer/VBoxContainer/action_list/input_button4
@onready var input_button5 = $Panel/MarginContainer/VBoxContainer/action_list/input_button5
@onready var reset_button = $Panel/MarginContainer/VBoxContainer/reset_exit_container/reset_button
@onready var exit_button = $Panel/MarginContainer/VBoxContainer/reset_exit_container/exit_button


var is_remapping = false 
var action_to_remap = null
var remapping_button = null
var current_focus_index = 0
var buttons = []

var input_actions = {
	"move_up": "Mover para arriba",
	"move_down": "Mover para abajo",
	"move_left": "Mover para la izquierda",
	"move_right": "Mover para la derecha",
	"interact": "Interactuar",
}

func _ready():
	buttons = [
		input_button1, input_button2, input_button3, input_button4, input_button5,
		reset_button, exit_button
	]
	_set_action_texts()
	_set_initial_focus()
	_set_button_sizing()
	_connect_buttons()
	
func _set_button_sizing():
	$Panel.custom_minimum_size = Vector2(400, 300) 


	$Panel.size_flags_horizontal = Control.SIZE_FILL
	$Panel.size_flags_vertical = Control.SIZE_FILL

	$Panel/MarginContainer.size_flags_horizontal = Control.SIZE_FILL
	$Panel/MarginContainer.size_flags_vertical = Control.SIZE_FILL

	$Panel/MarginContainer/VBoxContainer.size_flags_horizontal = Control.SIZE_FILL
	$Panel/MarginContainer/VBoxContainer.size_flags_vertical = Control.SIZE_FILL


	for child in $Panel/MarginContainer/VBoxContainer/action_list.get_children():
		if child is Button:
			child.custom_minimum_size = Vector2(350, 50) 
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			child.size_flags_vertical = Control.SIZE_EXPAND_FILL

	for child in $Panel/MarginContainer/VBoxContainer/reset_exit_container.get_children():
		if child is Button:
			child.custom_minimum_size = Vector2(350, 50) 
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			child.size_flags_vertical = Control.SIZE_EXPAND_FILL

	
func _set_action_texts():
	var action_buttons = [input_button1, input_button2, input_button3, input_button4, input_button5]
	var actions = input_actions.keys()
	
	for i in range(action_buttons.size()):
		var button = action_buttons[i]
		var action = actions[i]
		var action_label = button.get_node("MarginContainer/HBoxContainer/action")
		var input_label = button.get_node("MarginContainer/HBoxContainer/input")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _set_initial_focus():
	_grab_focus(input_button1)
	current_focus_index = 0

func _on_button_focus(button):
	button.modulate = Color(0.8, 0.8, 0.8)  

func _on_button_blur(button):
	button.modulate = Color(1, 1, 1)  

func _grab_focus(button):
	button.grab_focus()
	button.modulate = Color(0.8, 0.8, 0.8)  
	
func _connect_buttons():
	for button in buttons:
		button.focus_mode = Control.FOCUS_ALL
	reset_button.connect("pressed", Callable(self, "_on_reset_button_pressed"))
	exit_button.connect("pressed", Callable(self, "_on_exit_button_pressed"))

func _on_input_button_pressed(button, action):
	if is_remapping:
		var previous_event = InputMap.action_get_events(action_to_remap)
		if previous_event.size() > 0:
			remapping_button.get_node("MarginContainer/HBoxContainer/input").text = previous_event[0].as_text().trim_suffix(" (Physical)")
		else:
			remapping_button.get_node("MarginContainer/HBoxContainer/input").text = ""
	else:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.get_node("MarginContainer/HBoxContainer/input").text = "Seleccionar" 

func _input(event):
	if is_remapping:
		if (
			event is InputEventKey or
			(event is InputEventMouseButton and event.pressed) or 
			(event is InputEventJoypadButton and event.pressed)
		):
			if event is InputEventMouseButton and event.doubleclick:
				event.doubleclick = false 
				
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			if _is_duplicate(event):
				remapping_button.get_node("MarginContainer/HBoxContainer/input").text = "Ya está en uso"
			else:
				InputMap.action_erase_events(action_to_remap)
				InputMap.action_add_event(action_to_remap, event)
				_update_action_list(remapping_button, event)
			
			is_remapping = false
			remapping_button = null 
			action_to_remap = null 
			
			accept_event()
	elif event is InputEventKey:
		if event.is_action_pressed("ui_down"):
			_focus_next()
		elif event.is_action_pressed("ui_up"):
			_focus_prev()

func _is_duplicate(event):
	for action in input_actions.keys():
		if action != action_to_remap:  
			var events = InputMap.action_get_events(action)
			for existing_event in events:
				if event.as_text() == existing_event.as_text():
					return true
	return false

func _focus_next():
	current_focus_index = (current_focus_index + 1) % buttons.size()
	_grab_focus(buttons[current_focus_index])

func _focus_prev():
	current_focus_index = (current_focus_index - 1 + buttons.size()) % buttons.size()
	_grab_focus(buttons[current_focus_index])

	
func _update_action_list(button, event):
	button.get_node("MarginContainer/HBoxContainer/input").text = event.as_text().trim_suffix(" (Physical)")
	
func _on_reset_button_pressed():
	_set_action_texts()

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

