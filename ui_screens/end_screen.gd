extends CanvasLayer


func _ready() -> void:
	Transition.fade_in()
	await get_tree().create_timer(3).timeout
	Transition.fade_out()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("uid://bn0jv6rimentm")
