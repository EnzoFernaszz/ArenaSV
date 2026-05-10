extends Control

func _ready():
	# Assumindo que você chamou o botão de "BackButton"
	var back_button = $ButtonVoltar
	
	if back_button:
		back_button.pressed.connect(back_to_menu)

func back_to_menu():
	print("Returning to main menu...")
	get_tree().change_scene_to_file("res://Scenes/TilteScreen.tscn")
