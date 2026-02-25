extends Area2D

@onready var apple: Area2D = $"."


func _ready() -> void:
	apple.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	self.queue_free()
