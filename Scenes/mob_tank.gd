extends CharacterBody2D

signal died


var speed = randf_range(80, 120)
var health = 12.0
var score_value = 5

@onready var player = get_node("/root/Game/Player")


func _ready():
	%Slime.modulate = Color("9933e6ff")
	var game_score = get_node("/root/Game").score
	health *= 1.0 + (game_score / 50.0) * 0.8
	speed *= 1.0 + (game_score / 150.0)
	%Slime.play_walk()


func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()


func take_damage(amount = 1.0):
	%Slime.play_hurt()
	health -= amount
	if health <= 0:
		%Slime.play_hurt()
		health -= 1
	if health <= 0:
		get_node("/root/Game").score += 1
		var smoke_scene = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = smoke_scene.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		queue_free()
