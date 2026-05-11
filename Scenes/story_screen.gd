extends Control

func _ready():
	var buttonSkip = $PanelContainer/ScoreLabel.get_node("SkipButton")
	GerenciadorAudio.tocar_musica_historia()
	
	if buttonSkip:
		buttonSkip.pressed.connect(skip_to_game)

func skip_to_game():
	get_tree().change_scene_to_file("res://Scenes/survivors_game.tscn")

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/second_drawn.tscn")
