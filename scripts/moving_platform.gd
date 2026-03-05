extends AnimatableBody2D

var move: bool = false
var tween: Tween

@export var displacement_time: float = 2.0
@export var wait_time: float = 1.0
@export var target_marker: Marker2D


func _ready() -> void:
	self.tree_exited.connect(_on_moving_platform_tree_exited)
	var start_position = self.position
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, Global.P_POSITION, target_marker.global_position, displacement_time)
	tween.tween_property(self, Global.P_POSITION, start_position, displacement_time)
	tween.set_loops(0)

func _on_moving_platform_tree_exited() -> void:
	tween.kill()
