extends CharacterBody2D

var x_input: float
var is_facing_right: bool = true

@export var speed: float = 180.0
@export var jump_impulse: float = 330.0
@export var gravity: float = 980.0


func _physics_process(delta: float) -> void:
	_gravity(delta)
	_jump()
	_flip()
	_player_movement()
	move_and_slide()


func _flip() -> void:
	if (is_facing_right and self.velocity.x < 0) or (not is_facing_right and self.velocity.x > 0):
		self.scale.x *= -1
		is_facing_right = not is_facing_right


func _player_movement() -> void:
	var direction_in_x := Input.get_axis(Global.M_LEFT, Global.M_RIGHT)
	self.velocity.x = direction_in_x * speed


func _jump() -> void: 
	if is_on_floor():
		if Input.is_action_just_pressed(Global.A_JUMP):
			self.velocity.y = -jump_impulse # Es lo mismo que multiplicarlo por -1


func _gravity(delta: float) -> void:
	if not is_on_floor():
		self.velocity.y += (gravity * delta)
