class_name Hurtbox
extends Area2D

@export var health_node: Node

signal received_damage(damage: int)

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: Area2D) -> void:
	if hitbox is Hitbox:
		if health_node and "health" in health_node:
			health_node.health -= hitbox.damage
			received_damage.emit(hitbox.damage)
