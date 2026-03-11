extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)
	SignalManager.level_completed.connect(_on_level_completed)
	
	self.visible = true
	animation_player.play(Global.ANI_FADE_IN)


func _on_level_completed() -> void:
	animation_player.play(Global.ANI_FADE_OUT)


func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == Global.ANI_FADE_OUT:
		GameManager.load_next_level()
