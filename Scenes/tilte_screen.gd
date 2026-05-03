extends Control

@onready var hover_sound: AudioStreamPlayer = $HoverSound

var original_scales: Dictionary = {}

func _ready():
	for child in get_children():
		if child is Button:
			original_scales[child] = child.scale
			child.mouse_entered.connect(_on_button_mouse_entered.bind(child))
			child.mouse_exited.connect(_on_button_mouse_exited.bind(child))
			match child.name:
				"StartButton":
					child.pressed.connect(start_game)
				#"OptionsButton":
					#child.pressed.connect(open_options)
				#"QuitButton":
					#child.pressed.connect(quit_game)

func _on_button_mouse_entered(button: Button):
	hover_sound.play()
	var tween = create_tween()
	tween.tween_property(button, "scale", original_scales[button] * 1.1, 0.2)

func _on_button_mouse_exited(button: Button):
	var tween = create_tween()
	tween.tween_property(button, "scale", original_scales[button], 0.2)

func start_game():
	get_tree().change_scene_to_file("res://Scenes/game.gd")

#func open_options():
	#get_tree().change_scene_to_file("res://Options.tscn")

#func quit_game():
	#get_tree().quit()
