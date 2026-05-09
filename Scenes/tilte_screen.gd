extends Control

func _ready():
	var buttonStart = $VBoxContainer.get_node("Start")
	var buttonSettings = $VBoxContainer.get_node("Settings")
	var buttonExit = $VBoxContainer.get_node("Exit")
	
	if buttonStart:
		buttonStart.pressed.connect(start_game)
	
	if buttonSettings:
		pass

func start_game():
	print("Loading game scene...")
	get_tree().change_scene_to_file("res://Scenes/survivors_game.tscn")
