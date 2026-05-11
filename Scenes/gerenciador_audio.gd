extends Node

@onready var musica_historia = $AudioStreamPlayer

func tocar_musica_historia():
	if not musica_historia.playing:
		musica_historia.play()

func parar_musica_historia():
	musica_historia.stop()
