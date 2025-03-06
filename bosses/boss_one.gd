extends Boss

func _physics_process(delta: float) -> void:
	rotation += delta
	health_label.text = "HP: " + str(hp)
	if hp <= 0 and phase == 1:
		phase = 2
		hp = 500
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", get_viewport_rect().size / 2.0, 1.0)
		for shooter: Area2D in $Shooters.get_children():
			shooter.shooting_timer.wait_time = 0.05
	elif hp <= 0 and phase == 2:
		die()
	
	var areas: Array[Area2D] = self.get_overlapping_areas()
	for area: Area2D in areas:
		if area.is_in_group("player"):
			area.take_damage(10)
