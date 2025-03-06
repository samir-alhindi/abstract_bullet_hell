extends Area2D

@export var move_speed: int = 600
@export var damage_amount: int = 10
@export_enum("enemy", "player") var target: String = "player"


func _physics_process(delta: float) -> void:
	global_position += Vector2.UP.rotated(rotation) * move_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(target):
		area.take_damage(damage_amount)
		queue_free()
