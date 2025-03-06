extends CharacterBody2D

@export var hp: int = 300
@export var move_speed: int = 300
@export var acceleration: float = 100
const BULLET = preload("res://bullet/bullet.tscn")
const EXPLOSION = preload("uid://dc6g4psyiuxxw")
@onready var shooting_point: Marker2D = $ShootingPoint
@onready var shooting_timer: Timer = $ShootingTimer
@onready var health_label: Label = $CanvasLayer/HealthLabel
@onready var shoot_sound: AudioStreamPlayer = $ShootSound
@onready var sprite: ColorRect = $Sprite
@onready var sprite_2: ColorRect = $Sprite2
@onready var sprite_3: ColorRect = $Sprite3
@onready var sprite_4: ColorRect = $Sprite4
@onready var invincibility_timer: Timer = $InvincibilityTimer
@onready var hurt_sound: AudioStreamPlayer = $HurtSound

func _physics_process(delta: float) -> void:
	sprite.rotation += delta
	sprite_2.rotation -= delta
	sprite_3.rotation += delta
	sprite_4.rotation -= delta
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = velocity.move_toward(dir * move_speed, acceleration)
	position.x = clamp(position.x, 16, get_viewport_rect().size.x + 16)
	position.y = clamp(position.y, 16, get_viewport_rect().size.y - 16)
	if Input.is_action_pressed("shoot"):
		shoot()
	health_label.text = "HP: " + str(hp)
	if hp <= 0:
		Bus.player_dead.emit()
		var explosion: CPUParticles2D = EXPLOSION.instantiate()
		get_tree().get_first_node_in_group("game").add_child(explosion)
		explosion.global_position = self.global_position
		queue_free()
	
	move_and_slide()

func shoot() -> void:
	if shooting_timer.time_left: return
	shoot_sound.play()
	shooting_timer.start()
	var bullet: Area2D = BULLET.instantiate()
	bullet.target = "enemy"
	get_tree().get_first_node_in_group("game").add_child(bullet)
	bullet.global_position = shooting_point.global_position

func take_damage(damage_amount: int) -> void:
	if invincibility_timer.time_left: return
	hp -= damage_amount
	hurt_sound.play()
	invincibility_timer.start()
