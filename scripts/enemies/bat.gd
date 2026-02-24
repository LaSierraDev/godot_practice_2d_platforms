extends Enemy

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var detection_area: Area2D = $DetectionArea

var _is_waching_player: bool = false
var _is_following_player: bool = false
var following_position: Vector2

@export var following_time: float = 5.0
@export var initial_position: Vector2


func _ready() -> void:
	self.speed = 60
	self.initial_position = self.position
	collision_shape_2d.disabled = true
	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)
	if _player == null: 
		_player = get_tree().get_first_node_in_group(Global.G_PLAYER)


func _process(_delta: float) -> void:
	if _is_waching_player or _is_following_player:
		_flip()


func _physics_process(_delta: float) -> void:
	if _is_following_player:
		following_position = _player.position
	elif self.position != initial_position and not _is_following_player:
		following_position = initial_position
	_flip()
	_follow_position()
	move_and_slide()


func _on_body_entered(body: Node2D) -> void:
	if body == _player:
		_is_waching_player = true
		_is_following_player = true


func _on_body_exited(body: Node2D) -> void:
	if body == _player:
		_flip()
		await get_tree().create_timer(following_time).timeout
		_is_waching_player = false
		_is_following_player = false


func _flip() -> void:
	animated_sprite_2d.flip_h = following_position.x > self.position.x


func _follow_position() -> void:
	var following_vector: Vector2 = Vector2(following_position - self.position).normalized() #Desde el murcielago hasta el jugador
	self.velocity = following_vector * speed
