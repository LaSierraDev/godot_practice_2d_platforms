extends CharacterBody2D

var x_input: float

var is_facing_right: bool = true

@export var speed: float = 180
@export var jump_impulse: float = 50

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(Global.A_JUMP):
		velocity.y = jump_impulse
	
	if (is_facing_right and self.velocity.x < 0) or (not is_facing_right and self.velocity.x > 0):
		self.scale.x *= -1
		is_facing_right = not is_facing_right
	
	_player_movement()
	move_and_slide()

func _player_movement() -> void:
	var direction_in_x := Input.get_axis(Global.M_LEFT, Global.M_RIGHT)
	self.velocity.x = direction_in_x * speed
