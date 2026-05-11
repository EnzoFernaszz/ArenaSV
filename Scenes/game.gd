extends Node2D

var score = 0
var active_chest = null
const MAX_CHESTS = 1

@export var limite_esquerdo: float = -2250.0
@export var limite_direito: float = 2250.0
@export var limite_cima: float = -2250.0
@export var limite_baixo: float = 2250.0

const MOB = preload("res://Scenes/mob.tscn")
const MOB_FAST = preload("res://Scenes/mob_fast.tscn")
const MOB_TANK = preload("res://Scenes/mob_tank.tscn")

func _ready():
	GerenciadorAudio.parar_musica_historia()
	$Player/SomFundo.play()

func _process(_delta):
	%ScoreLabel.text = "SCORE: " + str(score)
	_update_difficulty()

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
	
	var pos = %PathFollow2D.global_position
	pos.x = clamp(pos.x, limite_esquerdo, limite_direito)
	pos.y = clamp(pos.y, limite_cima, limite_baixo)
	
	new_mob.global_position = pos
	add_child(new_mob)

func spawn_chest():
	if active_chest != null:
		return
		
	var chest_scene = preload("res://Scenes/chest.tscn")
	var chest = chest_scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	
	
	var pos = %PathFollow2D.global_position
	pos.x = clamp(pos.x, limite_esquerdo, limite_direito)
	pos.y = clamp(pos.y, limite_cima, limite_baixo)
	
	chest.global_position = pos
	chest.chest_touched.connect(_on_chest_chest_touched)
	add_child(chest)
	active_chest = chest

func _on_chest_timer_timeout():
	spawn_chest()

func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	$Player/SomGameOver.play()
	%GameOver.show()
	get_tree().paused = true

func _on_chest_chest_touched(chest) -> void:
	active_chest = chest
	%ChestTouched.get_node("Control").show_screen(chest)


func _on_button_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/TilteScreen.tscn")
