extends Boss

var dir: int = 1

func _physics_process(delta: float) -> void:
	rotation += delta * dir
	if phase == 1:
		if hp <= 0: start_phase_2();
	if phase == 2:
		if hp <= 0:
			die()

func _on_rotation_timer_timeout() -> void:
	dir *= -1

func start_phase_2() -> void:
	hp = 750
	for shooter: Area2D in shooters.get_children():
		shooter.shoot_time = 0.3
		shooter.bullet_scale = 0.6
	var tween: Tween = get_tree().create_tween()
	tween.tween_property($Sprite, "scale", Vector2(0.25, 0.25), 1.0)
	tween.tween_property(collision_shape_2d, "scale", Vector2(0.25, 0.25), 1.0)
	phase += 1
