class_name Enemy
extends CharacterBody2D

var is_facing_right: bool = false

@export var speed: float = 40.0
@export var jump_impulse: float = 330.0
@export var gravity: float = 980.0


func _flip() -> void:
	if (is_facing_right and self.velocity.x < 0) or (not is_facing_right and self.velocity.x > 0):
		self.scale.x *= -1
		is_facing_right = not is_facing_right


func _add_gravity(delta: float) -> void:
	if not is_on_floor():
		self.velocity.y += gravity * delta


func _horizontal_movement_on_floor() -> void:
	if is_on_floor():
		self.velocity.x = speed
		_flip()


func _horizontal_movement_on_air() -> void:
	if not is_on_floor():
		self.velocity.x = speed
		_flip()


func _horizontal_change_of_direction() -> void:
	if is_on_wall():
		_flip()
		speed *= -1
