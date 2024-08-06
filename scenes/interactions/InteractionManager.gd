extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $CanvasLayer/Label

const base_text = ""


var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		if not label.visible:
			_sort_active_areas_by_distance()
			label.text = base_text + active_areas[0].action_name
			#cambio el texto de "<boton> por la tecla asignada para interactuar"
			var interactButton = InputMap.action_get_events("interact").pop_at(0).as_text().trim_suffix(" (Physical)")
			label.text = label.text.replace("<boton>", interactButton)
			
		
			#label.global_position = active_areas[0].global_position
			#label.global_position.y -= 36
			#label.global_position.x -= label.size.x /2
			label.show()
			label.visible = true
			print("Showing label with text:", label.text)
			print("Label Position: ", label.global_position)
	else:
		if label.visible:
			label.hide()
			label.visible = false
			print("Hide label")


func _sort_active_areas_by_distance():
	for i in range(active_areas.size()):
		for j in range(i + 1, active_areas.size()):
			if _sort_by_distance_to_player(active_areas[i], active_areas[j]):
				var temp = active_areas[i]
				active_areas[i] = active_areas[j]
				active_areas[j] = temp


func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func interact():
	if active_areas.size() > 0:
		active_areas[0].interact.call()

func update_label_message(message: String):
	label.text = message
	if global.get_tts_enabled():
		global.speak(message)
