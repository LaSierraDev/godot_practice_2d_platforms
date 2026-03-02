extends AnimatableBody2D

@export var final_position_movement: Vector2
@export var time_to_displacement: float = 2.0

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, Global.P_POSITION, final_position_movement, time_to_displacement)
