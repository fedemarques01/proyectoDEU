extends StaticBody2D

@onready var interaction_area = $Ventana_alumnos
@export var interaction_message: String = "Horario de atención de 8:30 a 12 y de 14 a 17 hs."

func _ready(): #al interactuar, se interactua
	interaction_area.interact = Callable(self, "_mirar_horario_alumnos")

func _mirar_horario_alumnos(): #se pasa al manager la accion que se realiza (interaction_message)
	var interaction_manager = get_tree().root.find_child("InteractionManager", true, false)
	interaction_manager.update_label_message(interaction_message)
