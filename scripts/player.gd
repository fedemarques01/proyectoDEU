extends CharacterBody2D

var current_dir = "none"

func player():
	pass

func _ready():
	$AnimatedSprite2D.play("front_idle")
	add_to_group("player") 
	#global.test_start()

func _physics_process(delta):
	player_movement(delta)
	change_camera_to()
	handle_interaction_input()
	#print(position)

func player_movement(delta): #movimientos del jugador
	if Input.is_action_pressed("move_right"):
		play_anim(1)
		current_dir = "right"
		velocity.x = global.get_speed()
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		play_anim(1)
		current_dir = "left"
		velocity.x = - global.get_speed()
		velocity.y = 0
	elif Input.is_action_pressed("move_up"):
		play_anim(1)
		current_dir = "up"
		velocity.x = 0
		velocity.y = -  global.get_speed()
	elif Input.is_action_pressed("move_down"):
		play_anim(1)
		current_dir = "down"
		velocity.x = 0
		velocity.y =  global.get_speed()
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func play_anim(movement): #animaciones del player
	var dir = current_dir
	var anim = $AnimatedSprite2D
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	

func change_camera_to():
	#construyo la ruta del nodo
	var new_camera_node = get_node("Cameras/Camera2D_" + global.transition_to)
	if new_camera_node: #si la camara existe, la habilito
		if global.transition_to != "entrada_facu":
			new_camera_node.enabled = true
			$Cameras/Camera2D_entrada_facu.enabled = false
			
func handle_interaction_input():
	if Input.is_action_just_pressed("interact"):
		var interaction_manager = get_tree().root.find_child("InteractionManager", true, false)
		if interaction_manager:
			interaction_manager.interact()
			

