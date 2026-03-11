extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	self.visible = true
	animation_player.play(Global.ANI_FADE_IN)
