extends Control

func _ready():
	var buttonStart = $VBoxContainer/PanelContainer.get_node("StartButton")
	var buttonTutorial = $VBoxContainer/PanelContainer.get_node("TutorialButton")
	var buttonExit = $VBoxContainer/PanelContainer.get_node("ExitButton")
	
	if buttonStart:
		buttonStart.pressed.connect(start_game)
	
	if buttonTutorial:
		buttonTutorial.pressed.connect(open_tutorial)
		
	if buttonExit:
		buttonExit.pressed.connect(exit_game)

func start_game():
	get_tree().change_scene_to_file("res://Scenes/story_screen.tscn")

func open_tutorial():
	get_tree().change_scene_to_file("res://Scenes/tutorial_screen.tscn")

func exit_game():
	get_tree().quit()
