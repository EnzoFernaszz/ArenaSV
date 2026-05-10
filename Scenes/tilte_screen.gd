extends Control

func _ready():
	var buttonStart = $VBoxContainer.get_node("Start")
	var buttonTutorial = $VBoxContainer.get_node("Tutorial")
	var buttonExit = $VBoxContainer.get_node("Exit")
	
	if buttonStart:
		buttonStart.pressed.connect(start_game)
	
	if buttonTutorial:
		buttonTutorial.pressed.connect(open_tutorial)
		
	if buttonExit:
		buttonExit.pressed.connect(exit_game)

func start_game():
	print("Loading game scene...")
	get_tree().change_scene_to_file("res://Scenes/story_screen.tscn")

func open_tutorial():
	print("Loading tutorial scene...")
	get_tree().change_scene_to_file("res://Scenes/tutorial_screen.tscn")

func exit_game():
	print("Exiting game...")
	get_tree().quit()
