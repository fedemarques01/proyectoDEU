extends Camera2D

func _ready():
	var viewport = get_viewport()
	viewport.size_changed.connect(_on_size_changed)
	adjust_zoom()

func _on_size_changed():
	adjust_zoom()

func adjust_zoom():
	var screen_size = get_viewport().get_visible_rect().size
	var base_resolution = Vector2(576, 324) # Pon aquí la resolución base de tu juego
	var scale_factor = screen_size / base_resolution
	zoom = Vector2(scale_factor.x, scale_factor.y)

