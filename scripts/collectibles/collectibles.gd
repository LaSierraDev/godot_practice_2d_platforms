extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var points: int = 2


func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	audio_stream_player_2d.finished.connect(_on_audio_stream_player_2d_finished)


func _on_area_entered(_area: Area2D) -> void:
	GameManager.update_score(points)
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.PICKUP)
	self.visible = false

func _on_audio_stream_player_2d_finished() -> void:
	self.queue_free()
