extends Camera2D

@onready var player: CharacterBody2D = $"../Player"

var _player = null


func _ready() -> void:
	if _player == null:
		_player = player


func _process(_delta: float) -> void:
	if not _player:
		return
	
	if _player.position != self.position:
		self.position = _player.position


func _reset_position() -> void:
	self.position.x = 240.0
	self.position.y = 135.0
