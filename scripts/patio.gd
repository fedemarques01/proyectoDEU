extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Entity_container/player.position.x = global.player_transition_posx
	$Entity_container/player.position.y = global.player_transition_posy

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
func _on_pasillo_1_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_to = "planta_baja_pasillo_1"
		global.player_transition_posx = 1081
		global.player_transition_posy = 178
		global.transition_scene = true

func _on_pasillo_1_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false


func _on_pasillo_2_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_to = "planta_baja_pasillo_2"
		global.player_transition_posx = 1063
		global.player_transition_posy = 122
		global.transition_scene = true

func _on_pasillo_2_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
