extends Area2D


@export var points: int = 2

func _ready() -> void:
	self.area_entered.connect(_on_area_entered)


func _on_area_entered(_area: Area2D) -> void:
	GameManager.update_score(points)
	self.queue_free()
