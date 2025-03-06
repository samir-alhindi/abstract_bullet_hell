extends Area2D

@export var shoot_time: float = 0.2:
	set(val):
		if not $ShootingTimer:
			await self.ready
		$ShootingTimer.wait_time = val
		shoot_time = val
@export var bullet_scale: float = 1.0
@export var shooting_point_offset: int = -45
@onready var shooting_timer: Timer = $ShootingTimer
@onready var bullet_spot: Marker2D = $BulletSpot

const BULLET = preload("res://bullet/bullet.tscn")

func _ready() -> void:
	shooting_timer.wait_time = shoot_time
	bullet_spot.position.y = shooting_point_offset

func _on_shooting_timer_timeout() -> void:
	var bullet: Area2D = BULLET.instantiate()
	get_tree().get_first_node_in_group("game").add_child(bullet)
	bullet.target = "player"
	bullet.global_position = bullet_spot.global_position
	bullet.rotation = get_tree().get_first_node_in_group("enemy").rotation + self.rotation
	bullet.scale *= 2 * bullet_scale
