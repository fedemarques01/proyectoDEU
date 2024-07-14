extends StaticBody2D

@onready var interaction_area = $InteractionArea
@export var interaction_message: String = "Soy una Interacción de Prueba"

func _ready():
	interaction_area.interact = Callable(self, "_watch")

func _watch():
	var interaction_manager = get_tree().root.find_child("InteractionManager", true, false)
	interaction_manager.update_label_message(interaction_message)
	print("Interacting with:", interaction_message)
