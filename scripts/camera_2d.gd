extends Camera2D

var _player = null

func _init() -> void:
	self.position = Vector2(240,135)

func _ready() -> void:
	if _player == null:
		_player = get_tree().get_first_node_in_group(Global.G_PLAYER)
	

func _process(_delta: float) -> void:
	if not _player:
		return
	
	if _player.position != self.position:
		self.position = _player.position


func _reset_position() -> void:
	self.position.x = 240.0
	self.position.y = 135.0
