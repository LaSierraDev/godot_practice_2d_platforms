extends Node

const BUTTON_FOCUS = preload("uid://bsjvqtlsk5swi")
const ENEMY_DIE = preload("uid://bshm8e28hje8a")
const JUMP = preload("uid://dpvosiqf68iss")
const PICKUP = preload("uid://brrwsajp45unr")
const PLAYER_DIE = preload("uid://dgqfg731vltik")
const SUCCESS = preload("uid://w7aukbvau3ic")


func play_sfx(audio_stream_player: Variant, sfx: AudioStream, volume_db: float = 0.0) -> void:
	if not (audio_stream_player is AudioStreamPlayer or audio_stream_player is AudioStreamPlayer2D):
		DebugLog.log_rich("El AudioStream no es ni ASPlayer ni ASPlayer2D", DebugLog.LogType.ERROR)
		return
	audio_stream_player.stream = sfx
	audio_stream_player.volume_db = volume_db
	audio_stream_player.play()
