extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func change_scene():
	if global.transition_scene:
		var filename = "res://scenes/" + global.transition_to + ".tscn"
		#filename = "res://scenes/planta_baja_pasillo_2.tscn"
		get_tree().change_scene_to_file(filename)
		global.current_scene = global.transition_to
		global.transition_to = "none"


func _on_pb_pasillo_1_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_to = "planta_baja_pasillo_1"
		global.transition_scene = true
func _on_pb_pasillo_1_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func _on_pb_pasillo_2_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_to = "planta_baja_pasillo_2"
		global.transition_scene = true
func _on_pb_pasillo_2_transition_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

