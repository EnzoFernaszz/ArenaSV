extends Node2D

var score = 0
var active_chest = null
const MAX_CHESTS = 1

func _process(_delta):
	%ScoreLabel.text = "Score: " + str(score)
	_update_difficulty()

const MOB = preload("res://Scenes/mob.tscn")
const MOB_FAST = preload("res://Scenes/mob_fast.tscn")
const MOB_TANK = preload("res://Scenes/mob_tank.tscn")

func _update_difficulty():
	var spawn_timer = %Timer
	spawn_timer.wait_time = max(0.3, 2.0 / (1.0 + score / 40.0))

func spawn_mob():
	%PathFollow2D.progress_ratio = randf()
	var new_mob
	var fast_chance = min(0.4, score / 500.0)        
	var tank_chance = min(0.3, max(0, (score - 100) / 600.0)) 
	var roll = randf()
	if roll < tank_chance:
		new_mob = MOB_TANK.instantiate()
	elif roll < tank_chance + fast_chance:
		new_mob = MOB_FAST.instantiate()
	else:
		new_mob = MOB.instantiate()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func spawn_chest():
	if active_chest != null:
		return
	var chest_scene = preload("res://Scenes/chest.tscn")
	var chest = chest_scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	chest.global_position = %PathFollow2D.global_position
	chest.chest_touched.connect(_on_chest_chest_touched)
	add_child(chest)
	active_chest = chest

func _on_chest_timer_timeout():
	spawn_chest()

func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	%GameOver.show()
	get_tree().paused = true

func _on_chest_chest_touched(chest) -> void:
	active_chest = chest
	%ChestTouched.get_node("Control").show_screen(chest)
