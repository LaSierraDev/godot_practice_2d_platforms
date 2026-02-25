class_name Enemy
extends CharacterBody2D

@onready var hurtbox: Area2D = $Hurtbox

var is_facing_right: bool = false
var _player: CharacterBody2D = null

@export var speed: float = 30.0
@export var jump_impulse: float = 330.0
@export var gravity: float = 980.0


func _ready() -> void:
	if _player == null: 
		_player = get_tree().get_first_node_in_group(Global.G_PLAYER)
	hurtbox.area_entered.connect(_on_hurbox_area_entered)


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


func _on_hurbox_area_entered(area: Area2D) -> void:
	if _player.position.y < hurtbox.global_position.y:
		queue_free()


func destroy_me() -> void:
	queue_free()
