extends Control

@onready var input_button_scene = preload("res://scenes/input_button.tscn")
@onready var action_list  = $Panel/MarginContainer/VBoxContainer/ScrollContainer/action_list

var is_remapping = false 
var action_to_remap = null
var remapping_button = null
var current_focus_index = -1 

var input_actions = {
	"move_up": "Mover para arriba",
	"move_down": "Mover para abajo",
	"move_left": "Mover para la izquierda",
	"move_right": "Mover para la derecha",
#	"interact": "Interactuar",
}

func _ready():
	_create_action_list()

		
func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("action")
		var input_label = button.find_child("input")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		
		if events.size()>0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
			
		action_list.add_child(button)
		
		button.focus_mode = Control.FOCUS_ALL
		button.connect("focus_entered", Callable(self, "_on_button_focus_entered"))
		button.connect("focus_exited", Callable(self, "_on_button_focus_exited"))

			
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if is_remapping:
		var previous_event = InputMap.action_get_events(action_to_remap)
		if previous_event.size() > 0:
			remapping_button.find_child("input").text = previous_event[0].as_text().trim_suffix(" (Physical)")
		else:
			remapping_button.find_child("input").text = ""
	else:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("input").text = "Seleccionar" 
		
		
func _input(event):
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed) || 
			(event is InputEventJoypadButton && event.pressed)
		):
			if (event is InputEventMouseButton && event.double_click):
				event.double_click = false 
				
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			print(str(_is_duplicate(event)))
			if _is_duplicate(event):
				remapping_button.find_child("input").text = "Ya está en uso"
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
	if current_focus_index >= 0 and action_list.get_child_count() > 0:
		current_focus_index = (current_focus_index + 1) % action_list.get_child_count()
		action_list.get_child(current_focus_index).grab_focus()

func _focus_prev():
	if current_focus_index >= 0 and action_list.get_child_count() > 0:
		current_focus_index = (current_focus_index - 1 + action_list.get_child_count()) % action_list.get_child_count()
		action_list.get_child(current_focus_index).grab_focus()

		
func _update_action_list(button, event):
	button.find_child("input").text = event.as_text().trim_suffix(" (Physical)")
	

func _on_reset_button_pressed():
	_create_action_list()
	


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
