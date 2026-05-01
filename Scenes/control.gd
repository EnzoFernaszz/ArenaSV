extends Control

func _ready():
	visible = false
	card0.pressed.connect(_on_card_pressed.bind(card0))
	card1.pressed.connect(_on_card_pressed.bind(card1))
	card2.pressed.connect(_on_card_pressed.bind(card2))
	ans0.pressed.connect(_on_answer_pressed.bind(ans0))
	ans1.pressed.connect(_on_answer_pressed.bind(ans1))
	ans2.pressed.connect(_on_answer_pressed.bind(ans2))

const UPGRADES = [
	{"name": "Fire Damage", "desc": "+25% damage", "type": "damage"},
	{"name": "Shoot Speed", "desc": "+30% fire rate", "type": "speed"},
	{"name": "Energy Shield", "desc": "+40 HP", "type": "shield"},
	{"name": "Shotgun", "desc": "3-bullet spread shot", "type": "shotgun"},
	{"name": "Sniper", "desc": "Piercing shoot", "type": "sniper"}
]

const QUESTIONS = [
	{"seq": "3 — 6 — 9 — ?", "correct": 12, "options": [9, 12, 15]},
	{"seq": "2 — 5 — 8 — ?", "correct": 11, "options": [10, 11, 13]},
	{"seq": "10 — 7 — 4 — ?", "correct": 1,  "options": [1, 2, 3]},
	{"seq": "4 — 8 — 12 — ?", "correct": 16, "options": [14, 16, 18]},
	{"seq": "1 — 4 — 7 — ?",  "correct": 10, "options": [9, 10, 11]},
]

var selected_upgrade = null
var current_question = null
var timer_tween = null

@onready var card0 = %Card0
@onready var card1 = %Card1
@onready var card2 = %Card2
@onready var question_area = %QuestionArea
@onready var sequence_label = %SequenceLabel
@onready var timer_bar = %ProgressBar
@onready var ans0 = %Answer0
@onready var ans1 = %Answer1
@onready var ans2 = %Answer2

func show_screen():
	visible = true
	get_tree().paused = true
	question_area.visible = false
	var player = get_tree().get_first_node_in_group("player")
	
	var upgrades = UPGRADES.duplicate()
	
	if player.get_node("Gun").gun_type == "shotgun":
		upgrades = [
		{"name": "Fire Damage", "desc": "+25% damage", "type": "damage"},
		{"name": "Shoot Speed", "desc": "+30% fire rate", "type": "speed"},
		{"name": "Energy Shield", "desc": "+40 HP", "type": "shield"},
		{"name": "Sniper", "desc": "Piercing shoot", "type": "sniper"}
		]
	elif player.get_node("Gun").gun_type == "sniper":
		upgrades = [
		{"name": "Fire Damage", "desc": "+25% damage", "type": "damage"},
		{"name": "Shoot Speed", "desc": "+30% fire rate", "type": "speed"},
		{"name": "Energy Shield", "desc": "+40 HP", "type": "shield"},
		{"name": "Shotgun", "desc": "3-bullet spread shot", "type": "shotgun"},
		]
	upgrades.shuffle()
	
	card0.text = upgrades[0]["name"]
	card1.text = upgrades[1]["name"]
	card2.text = upgrades[2]["name"]
	
	card0.set_meta("upgrade", upgrades[0])
	card1.set_meta("upgrade", upgrades[1])
	card2.set_meta("upgrade", upgrades[2])

func _on_card_pressed(card):
	selected_upgrade = card.get_meta("upgrade")
	question_area.visible = true
	_load_question()

func _load_question():
	current_question = QUESTIONS[randi() % QUESTIONS.size()]
	sequence_label.text = current_question["seq"]
	
	var options = current_question["options"].duplicate()
	options.shuffle()
	ans0.text = str(options[0])
	ans1.text = str(options[1])
	ans2.text = str(options[2])
	ans0.set_meta("value", options[0])
	ans1.set_meta("value", options[1])
	ans2.set_meta("value", options[2])
	
	timer_bar.value = 100
	if timer_tween:
		timer_tween.kill()
	timer_tween = create_tween()
	timer_tween.tween_property(timer_bar, "value", 0, 10.0)
	timer_tween.tween_callback(_on_timeout)

func _on_answer_pressed(button):
	if timer_tween:
		timer_tween.kill()
	if button.get_meta("value") == current_question["correct"]:
		_apply_upgrade()
	else:
		_spawn_punishment()
	_close()

func _on_timeout():
	_close()

func _apply_upgrade():
	var player = get_tree().get_first_node_in_group("player")
	match selected_upgrade["type"]:
		"damage": player.damage_multiplier += 0.25
		"speed":  player.get_node("Gun/Timer").wait_time *= 0.7
		"shield":
			player.shield += 25
		"shotgun": player.get_node("Gun").gun_type = "shotgun"
		"sniper": player.get_node("Gun").gun_type = "sniper"

func _spawn_punishment():
	pass

func _close():
	visible = false
	get_tree().paused = false
