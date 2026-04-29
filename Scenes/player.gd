extends CharacterBody2D

signal health_depleted

var health = 100.0
var damage_multiplier = 1.0
var max_health = 100
var shield = 0.0
var max_shield = 50.0


func _physics_process(delta):
	const SPEED = 600.0
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	# Taking damage — shield absorbs first
	const DAMAGE_RATE = 6.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs:
		var damage = DAMAGE_RATE * overlapping_mobs.size() * delta
		if shield > 0.0:
			shield -= damage
			if shield < 0.0:
				# damage overflow spills into health
				health += shield
				shield = 0.0
		else:
			health -= damage
		if health <= 0.0:
			health_depleted.emit()
	%HealthBar.value = health
	%ShieldBar.value = shield
