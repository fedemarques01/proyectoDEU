extends Node2D

func _ready(): #tomo el nombre desde current_scene, lo edito para que sea legible
	var zoneName =  global.current_scene.replace("_"," ")
	zoneName =  zoneName.replace("facu","facultad")
	zoneName =  zoneName.replace("1","superior")
	zoneName =  zoneName.replace("2","inferior")
	
	#cargo el label e inicio la animacion
	$AnimationPlayer/CanvasLayer/Label.text = capitalize_first_word(zoneName)
	$AnimationPlayer.play("fade")

func capitalize_first_word(text: String) -> String: #mayuscula a la primer palabra
	if text.length() == 0:
		return text
	return text.substr(0, 1).to_upper() + text.substr(1)
