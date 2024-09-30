extends StaticBody2D

@onready var interaction_area = $Mapa_facu
@export var interaction_message: String = "Muestra el mapa de la facultad"

func _ready(): #al interactuar, se interactua
	interaction_area.interact = Callable(self, "_mirar_mapa")

func _mirar_mapa(): #se pasa al manager la accion que se realiza (interaction_message)
	var interaction_manager = get_tree().root.find_child("InteractionManager", true, false)
	interaction_manager.update_label_message(interaction_message)
