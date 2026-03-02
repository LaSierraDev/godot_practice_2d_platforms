extends AnimatableBody2D

var move: bool = false

@export var displacement_time: float = 2.0
@export var wait_time: float = 1.0
@export var target_marker: Marker2D


func _ready() -> void:
	var start_position = self.position
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, Global.P_POSITION, target_marker.global_position, displacement_time)
	tween.tween_property(self, Global.P_POSITION, start_position, displacement_time)
	tween.set_loops(0)
