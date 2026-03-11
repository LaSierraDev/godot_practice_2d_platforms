extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	self.area_entered.connect(_on_area_entered)


func _on_area_entered(_area: Area2D) -> void:
	SignalManager.level_completed.emit()
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.SUCCESS)
