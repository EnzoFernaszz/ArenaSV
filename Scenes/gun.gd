extends Area2D

var gun_type = "pistol"

const PISTOL_TEX = preload("res://pistol/pistol.png")
const SHOTGUN_TEX = preload("res://pistol/shotgun.png")
const SNIPER_TEX = preload("res://pistol/Sniper.png")

func _process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var nearest = enemies_in_range[0]
		for enemy in enemies_in_range:
			if global_position.distance_to(enemy.global_position) < global_position.distance_to(nearest.global_position):
				nearest = enemy
		look_at(nearest.global_position)


func shoot():
	match gun_type:
		"pistol":  _shoot_pistol()
		"shotgun": _shoot_shotgun()
		"sniper":  _shoot_sniper()
		

func set_gun_type(type: String):
	gun_type = type
	match type:
		"pistol":  $WeaponPivot/Pistol.texture = PISTOL_TEX
		"shotgun": $WeaponPivot/Pistol.texture = SHOTGUN_TEX
		"sniper":  $WeaponPivot/Pistol.texture = SNIPER_TEX

func _shoot_pistol():
	_spawn_bullet(0.0,false)
	

func _shoot_shotgun():
	_spawn_bullet(0.0,false)
	_spawn_bullet(0.3,false)
	_spawn_bullet(-0.3,false)

func _shoot_sniper():
	var bullet = _spawn_bullet(0.0, true)
	bullet.damage_multiplier = 3.0

func _spawn_bullet(angle_offset: float, is_piercing: bool) -> Area2D:
	const BULLET = preload("res://Scenes/bullet_2d.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_transform = %ShootingPoint.global_transform
	new_bullet.rotation += angle_offset
	new_bullet.piercing = is_piercing
	%ShootingPoint.add_child(new_bullet)
	return new_bullet

func _on_timer_timeout() -> void:
	shoot()
