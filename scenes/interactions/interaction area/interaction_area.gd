extends Area2D
class_name InteractionArea
@export var action_name: String = "interact"

var interact: Callable = func():
	pass

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("player"):  
		print("Player entered interaction area")
		InteractionManager.register_area(self)


func _on_body_exited(body):
	if body.is_in_group("player"): 
		print("Player left interaction area")
		InteractionManager.unregister_area(self)
