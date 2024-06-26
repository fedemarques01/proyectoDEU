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
func _on_entrada_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_to = "entrada_facu"
		global.player_transition_posx = 34
		global.player_transition_posy = 492
		global.transition_scene = true

func _on_entrada_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func _on_patio_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_to = "patio"
		calculate_pos_transition_patio()
		global.transition_scene = true

func _on_patio_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func calculate_pos_transition_patio():
	if $Entity_container/player.position.x < 500:
		global.player_transition_posx = 72
	elif $Entity_container/player.position.x < 1500:
		global.player_transition_posx = 685
	else:
		global.player_transition_posx = 1466
	global.player_transition_posy = 874
