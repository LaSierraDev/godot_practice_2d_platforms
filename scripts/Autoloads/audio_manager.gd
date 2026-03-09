extends Node

const BIT_BIT_LOOP = preload("uid://d4af8c602dmdv")
const BUTTON_FOCUS = preload("uid://bsjvqtlsk5swi")
const ENEMY_DIE = preload("uid://bshm8e28hje8a")
const JUMP = preload("uid://dpvosiqf68iss")
const PICKUP = preload("uid://brrwsajp45unr")
const PLAYER_DIE = preload("uid://dgqfg731vltik")
const SUCCESS = preload("uid://w7aukbvau3ic")


var is_sfx_active: bool = true
var is_music_active: bool = true


func play_sfx(audio_stream_player: Variant, sfx: AudioStream, volume_db: float = 0.0) -> void:
	if not (audio_stream_player is AudioStreamPlayer or audio_stream_player is AudioStreamPlayer2D):
		DebugLog.log_rich("El AudioStream no es ni ASPlayer ni ASPlayer2D", DebugLog.LogType.ERROR)
		return
	
	if is_sfx_active:
		audio_stream_player.stream = sfx
		audio_stream_player.volume_db = volume_db
		audio_stream_player.play()


func toggle_sfx() -> void:
	is_sfx_active = not is_sfx_active


func toggle_music() -> void:
	is_music_active = not is_music_active


func play_music(audio_stream_player: Variant, music: AudioStream, volume_db: float = 0.0) -> void:
	if is_music_active:
		audio_stream_player.stream = music
		audio_stream_player.volume_db = volume_db
		audio_stream_player.play()


func reset_audio() -> void:
	is_music_active = true
	is_sfx_active = true
