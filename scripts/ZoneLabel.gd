extends Node2D

func _ready(): #tomo el nombre desde current_scene, lo edito para que sea legible
	var zoneName =  global.current_scene.replace("_"," ")
	zoneName =  zoneName.replace("facu","facultad")
	zoneName =  zoneName.replace("1","superior")
	zoneName =  zoneName.replace("2","inferior")
	
	#cargo el label e inicio la animacion
	$AnimationPlayer/CanvasLayer/Label.text = zoneName
	$AnimationPlayer.play("fade")
