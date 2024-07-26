extends Area2D
class_name InteractionArea
@export var action_name: String = "Default"

var interact: Callable = func():
	pass

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.is_in_group("player"):
		InteractionManager.register_area(self)
		if global.tts_enabled:
			global.speak(self.action_name)


func _on_body_exited(body):
	if body.is_in_group("player"):
		InteractionManager.unregister_area(self)
