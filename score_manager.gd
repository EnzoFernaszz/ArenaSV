extends Node

const SAVE_PATH = "user://scores.dat"
var high_scores = []

func _ready():
	load_scores()

func add_score(score: int):
	high_scores.append(score)
	high_scores.sort()
	high_scores.reverse()
	if high_scores.size() > 5:
		high_scores.resize(5)
	save_scores()

func save_scores():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(high_scores)

func load_scores():
	if not FileAccess.file_exists(SAVE_PATH):
		high_scores = []
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	high_scores = file.get_var()
