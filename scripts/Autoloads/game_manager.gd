extends Node

const MAIN_MENU: PackedScene = preload("uid://d1flsgnad5ehg")
const END_SCREEN: PackedScene  = preload("uid://dceneyecdncd4")

const LEVELS: Dictionary = {
	1: preload("uid://qo0wlebs8u66"),
	2: preload("uid://bvmlrytyveopv"), 
}

var game_over: bool = false
var current_level: int = 0
var current_score: int = 0
var high_score: int = 0

@export var wait_time_to_reset_level: float = 1.0


func load_next_level() -> void:
	current_level += 1
	
	if current_level > LEVELS.size():
		_score_screen()
	else: 
		get_tree().change_scene_to_packed.call_deferred(LEVELS[current_level])


func _ready() -> void:
	SignalManager.next_level.connect(_on_next_level)
	SignalManager.player_dead.connect(_on_player_dead)



func _score_screen() -> void: 
		get_tree().change_scene_to_packed.call_deferred(END_SCREEN)


func restart_game() -> void:
	current_level = 0
	current_score = 0
	get_tree().change_scene_to_packed.call_deferred(MAIN_MENU)


func _reset_level() -> void:
	current_score = 0
	get_tree().change_scene_to_packed(LEVELS[current_level])


func _on_next_level() -> void:
	load_next_level()


func _on_player_dead() -> void:
	await get_tree().create_timer(wait_time_to_reset_level).timeout
	_reset_level()
