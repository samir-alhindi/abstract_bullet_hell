class_name Boss extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hurt_sound: AudioStreamPlayer = $HurtSound
@onready var health_label: Label = $HealthLabel
@onready var shooters: Node2D = $Shooters
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@export var hp: int = 100
const EXPLOSION: PackedScene = preload("uid://dc6g4psyiuxxw")
var phase: int = 1

func _process(delta: float) -> void:
	health_label.text = "HP = " + str(hp)

func take_damage(damage_amount: int) -> void:
	hp -= damage_amount
	hurt_sound.play()
	if not animation_player.is_playing():
		animation_player.play("hurt")

func die() -> void:
	queue_free()
	var explosion: CPUParticles2D = EXPLOSION.instantiate()
	get_tree().get_first_node_in_group("game").add_child(explosion)
	explosion.global_position = self.global_position
	Bus.boss_dead.emit()
