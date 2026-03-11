extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(_area: Area2D) -> void:
	await get_tree().create_timer(Global.TIME_FADE_IN_OUT).timeout
	GameManager.load_next_level()
