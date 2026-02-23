extends Enemy


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	_add_gravity(delta)
	_horizontal_change_of_direction()
	_horizontal_movement_on_floor()
	move_and_slide()
