extends Area2D

@export var parent: CharacterBody2D

func take_damage(damage_amount: int) -> void:
	parent.take_damage(damage_amount)
