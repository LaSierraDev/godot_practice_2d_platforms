extends Enemy

@onready var ray_cast_2d: RayCast2D = $RayCast2D


func _physics_process(delta: float) -> void:
	_add_gravity(delta)
	_horizontal_change_of_direction()
	_horizontal_movement_on_floor()
	move_and_slide()


func _horizontal_change_of_direction() -> void:
	if is_on_wall() or not ray_cast_2d.is_colliding():
		_flip()
		speed *= -1
