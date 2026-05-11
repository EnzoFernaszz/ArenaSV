extends Control

func _ready():
	GerenciadorAudio.tocar_musica_historia()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/second_drawn.tscn")
