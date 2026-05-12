extends Node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
