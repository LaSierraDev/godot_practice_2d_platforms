extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	SignalManager.level_completed.connect(_on_level_completed)
	
	self.visible = true
	animation_player.play(Global.ANI_FADE_IN)


func _on_level_completed() -> void:
	animation_player.play(Global.ANI_FADE_OUT)
