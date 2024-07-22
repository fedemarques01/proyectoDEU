extends Node

@onready var music_player = AudioStreamPlayer.new()

func _ready():
	add_child(music_player)

	var music_stream = preload("res://music/meet-the-fish-loop.wav") as AudioStream
	music_player.stream = music_stream
	music_player.connect("finished", Callable(self, "_on_music_finished"))
	music_player.play()

func play_music():
	music_player.play()

func stop_music():
	music_player.stop()

func toggle_music():
	if music_player.playing:
		music_player.stop()
	else:
		music_player.play()

func is_music_playing():
	return music_player.playing
