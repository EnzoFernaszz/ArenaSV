extends Area2D

var gun_type = "pistol"

func _process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)


func shoot():
	match gun_type:
		"pistol":  _shoot_pistol()
		"shotgun": _shoot_shotgun()
		"sniper":  _shoot_sniper()

func _shoot_pistol():
	_spawn_bullet(0.0,false)
	

func _shoot_shotgun():
	_spawn_bullet(0.0,false)
	_spawn_bullet(0.3,false)
	_spawn_bullet(-0.3,false)

func _shoot_sniper():
	_spawn_bullet(0.0,true)
	

func _spawn_bullet(angle_offset: float, is_piercing: bool):
	const BULLET = preload("res://Scenes/bullet_2d.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %ShootingPoint.global_transform
	new_bullet.rotation += angle_offset
	new_bullet.piercing = is_piercing
	%ShootingPoint.add_child(new_bullet)

func _on_timer_timeout() -> void:
	shoot()
