extends StaticBody2D

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_watch")

func _watch():
	print("test")
