extends Node2D

func _draw() -> void:
	draw_circle(Vector2.ZERO, 50, Color.RED, false, 7)
	draw_circle(Vector2.ZERO, 30, Color.BLACK, false, 2)
	draw_circle(Vector2(0, 10), 15, Color.RED, true)
