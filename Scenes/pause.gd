extends Node

@export var pause_menu: Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_menu.visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused
