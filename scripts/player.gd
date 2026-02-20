extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var coyote_trigger_area_2d: Area2D = $CoyoteTriggerArea2D

var x_input: float
var is_facing_right: bool = true
var is_coyote_time: bool = false

@export var speed: float = 180.0
@export var jump_impulse: float = 360.0
@export var gravity: float = 980.0
@export var coyote_time: float = 0.1


func _ready() -> void:
	coyote_trigger_area_2d.body_exited.connect(_on_body_exited)
	coyote_trigger_area_2d.body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	_update_animation()


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
	if is_on_floor() or is_coyote_time:
		if Input.is_action_just_pressed(Global.A_JUMP):
			self.velocity.y = -jump_impulse # Es lo mismo que multiplicarlo por -1


func _gravity(delta: float) -> void:
	if not is_on_floor():
		self.velocity.y += (gravity * delta)


func _update_animation() -> void:
	if self.velocity.x != 0:
		animated_sprite.play(Global.MA_RUN)
	
	if self.velocity.y > 0:
		animated_sprite.play(Global.AA_FALL)
	elif self.velocity.y < 0:
		animated_sprite.play(Global.AA_JUMP)
	
	if self.velocity == Vector2(0,0):
		animated_sprite.play(Global.MA_IDLE)


func _deactive_coyote_time() -> void:
	print("Ya no estoy en el suelo y me estoy cayendo")
	await get_tree().create_timer(coyote_time).timeout 
	is_coyote_time = false
	print("Coyote time desactivado")


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group(Global.G_FLOOR) and self.velocity.y >= 0:
		is_coyote_time = true
		_deactive_coyote_time()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(Global.G_FLOOR):
		is_coyote_time = false
