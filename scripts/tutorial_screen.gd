extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#inicio las animaciones de los gifs
	$"CanvasLayer/Tutorial Container/HSplitContainer/VBoxContainer2/AnimatedSprite2D2".play("default")
	$"CanvasLayer/Tutorial Container/HSplitContainer/VBoxContainer/AnimatedSprite2D".play("default")
	
	#cambio el texto de "<controles> por las teclas asignadas para moverse"
	var labelControles = $"CanvasLayer/Tutorial Container/HSplitContainer/VBoxContainer/Label"
	var interactControl = ObtenerControlesMovimiento()
	labelControles.text = labelControles.text.replace("<controles>", interactControl)
	
	#cambio el texto de "<boton> por la tecla asignada para interactuar"
	var interactButton = InputMap.action_get_events("interact").pop_at(0).as_text().trim_suffix(" (Physical)")
	var labelBoton = $"CanvasLayer/Tutorial Container/VBoxContainer/Label3" 
	labelBoton.text = labelBoton.text.replace("<boton>", interactButton)

func ObtenerControlesMovimiento(): #obtengo las teclas asignadas para movimiento
	var controles = ""
	controles += InputMap.action_get_events("move_up").pop_at(0).as_text().trim_suffix(" (Physical)")+" "
	controles += InputMap.action_get_events("move_left").pop_at(0).as_text().trim_suffix(" (Physical)")+" "
	controles += InputMap.action_get_events("move_down").pop_at(0).as_text().trim_suffix(" (Physical)")+" "
	controles += InputMap.action_get_events("move_right").pop_at(0).as_text().trim_suffix(" (Physical)")
	return controles

func _input(event): #espera el input para pausar
	if event is InputEventKey and event.is_action_pressed("interact"):
		var filename = "res://scenes/" + global.current_scene + ".tscn"
		get_tree().change_scene_to_file(filename)
