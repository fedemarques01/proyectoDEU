extends StaticBody2D

@onready var interaction_area = $Buffet
@export var interaction_message: String = "Horario de atención: Lunes a viernes de 8 a 20 hs."

func _ready(): #al interactuar, se interactua
	interaction_area.interact = Callable(self, "_mirar_horario_alumnos")

func _mirar_horario_alumnos(): #se pasa al manager la accion que se realiza (interaction_message)
	var interaction_manager = get_tree().root.find_child("InteractionManager", true, false)
	interaction_manager.update_label_message(interaction_message)
