extends Node2D

var pause_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	$Entity_container/player.position.x = global.player_transition_posx
	$Entity_container/player.position.y = global.player_transition_posy
	
	
	#prelodea el menu de pausa
	var pause_menu_scene = preload("res://scenes/pause_menu.tscn")
	pause_menu = pause_menu_scene.instantiate()
	get_tree().root.call_deferred("add_child", pause_menu)  
	pause_menu.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	pause_menu.hide()  


func _input(event): #espera el input para pausar
	if event is InputEventKey and event.is_action_pressed("cancel"):
		global.toggle_pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


#en caso de cambiar de escena, busco la escena y seteo la current_scene en global
func change_scene():
	if global.transition_scene:
		var filename = "res://scenes/" + global.transition_to + ".tscn"
		get_tree().change_scene_to_file(filename)
		global.current_scene = global.transition_to

#en caso de colisionar con el trigger de transicion, se cambia la escena
func _on_pb_pasillo_1_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_to = "planta_baja_pasillo_1"
		global.player_transition_posx = 2103
		global.player_transition_posy = 120
		global.transition_scene = true
func _on_pb_pasillo_1_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func _on_pb_pasillo_2_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_to = "planta_baja_pasillo_2"
		global.player_transition_posx = 2043
		global.player_transition_posy = 120
		global.transition_scene = true
func _on_pb_pasillo_2_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false


func _on_pb_1_piso_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_to = "primer_piso"
		global.player_transition_posx = 1438
		global.player_transition_posy = -28
		global.transition_scene = true


func _on_pb_1_piso_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
