class_name Enemy
extends CharacterBody2D

@onready var hurtbox: Area2D = $Hurtbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var _is_facing_right: bool = false
var _is_inside_screen: bool = false
var _player: CharacterBody2D = null
var _deactivated_time: float = 1.0

@export var speed: float = 30.0
@export var jump_impulse: float = 330.0
@export var gravity: float = 980.0
@export var inverse: bool = false


## -*- ENGINE CALLBACKS -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- ##
func _ready() -> void:
	if _player == null: 
		_player = get_tree().get_first_node_in_group(Global.G_PLAYER)
	
	hurtbox.area_entered.connect(_on_hurbox_area_entered)
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)
	visible_on_screen_notifier_2d.screen_entered.connect(_on_screen_entered_screen_notifier)
	visible_on_screen_notifier_2d.screen_exited.connect(_on_screen_exited_screen_notifier)
	


## -*- PRIVATE FUNCS -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- ##
func _flip() -> void:
	if (_is_facing_right and self.velocity.x < 0) or (not _is_facing_right and self.velocity.x > 0):
		self.scale.x *= -1
		_is_facing_right = not _is_facing_right


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


func _activation(yon: bool) -> void:
	set_process(yon)
	set_physics_process(yon)


## -*- PUBLIC FUNCS -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- ##
func destroy_me() -> void:
	queue_free()


func hit() -> void:
	animation_player.play(Global.ANI_DISSAPIAR, true)
	stand() 

func stand() -> void: 
	animated_sprite_2d.pause()
	_activation(false)

## -*- SIGNALS FUNCS -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- ##
func _on_hurbox_area_entered(_area: Area2D) -> void:
	if _player.position.y < hurtbox.global_position.y:
		hit()


func _on_animation_player_animation_finished(_ani_name: StringName) -> void:
	destroy_me()


func _on_screen_entered_screen_notifier() -> void:
	_is_inside_screen = true
	_activation(_is_inside_screen)


func _on_screen_exited_screen_notifier() -> void:
	_is_inside_screen = false
	await get_tree().create_timer(_deactivated_time).timeout
	_activation(_is_inside_screen)
