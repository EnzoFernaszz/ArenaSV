extends Control

@export var next_scene: String = ""
var story_images = []
var current_index = 0
var auto_timer = 0.0
const AUTO_TIME = 5.0  # seconds per screen

func setup(images: Array, next: String):
	story_images = images
	next_scene = next
	_show_image(0)

func _process(delta):
	auto_timer += delta
	if auto_timer >= AUTO_TIME:
		_advance()

func _show_image(index: int):
	auto_timer = 0.0
	%StoryImage.texture = story_images[index]

func _advance():
	current_index += 1
	if current_index >= story_images.size():
		get_tree().change_scene_to_file(next_scene)
	else:
		_show_image(current_index)

func _on_click_area_pressed():
	_advance()

func _on_skip_button_pressed():
	get_tree().change_scene_to_file(next_scene)
