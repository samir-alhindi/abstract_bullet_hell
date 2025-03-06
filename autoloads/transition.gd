extends CanvasLayer

@onready var black_screen: ColorRect = $BlackScreen
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func fade_in() -> void:
	animation_player.play("fade in")

func fade_out() -> void:
	animation_player.play("fade out")
