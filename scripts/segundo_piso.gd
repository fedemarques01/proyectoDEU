extends Node2D

var pause_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	
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
	pass
