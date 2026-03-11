extends Node

const MAIN_MENU: PackedScene = preload("uid://d1flsgnad5ehg")
const END_SCREEN: PackedScene  = preload("uid://dceneyecdncd4")

const LEVELS: Dictionary = {
	1: preload("uid://qo0wlebs8u66"),
	2: preload("uid://bvmlrytyveopv"), 
}

@onready var dataio: Dataio = Dataio.new()

var game_over: bool = false
var current_level: int = 0
var current_score: int = 0
var high_score: int = 0
var lives: int = 3

@export var wait_time_to_reset_level: float = 0.5


func load_next_level() -> void:
	current_level += 1
	
	if current_level > LEVELS.size():
		_score_screen()
	else: 
		get_tree().change_scene_to_packed.call_deferred(LEVELS[current_level])
	high_score = current_score
	SignalManager.score_increase.emit()
	save_high_score()


func update_score(points: int) -> void:
	current_score += points
	SignalManager.score_increase.emit()


func restart_game() -> void:
	current_level = 0
	current_score = 0
	lives = 3
	get_tree().change_scene_to_packed.call_deferred(MAIN_MENU)


func save_high_score() -> void:
	if current_score >= high_score:
		high_score = current_score
		dataio.save_data(high_score)


func load_high_score() -> void:
	high_score = dataio.load_data()


func _ready() -> void:
	SignalManager.next_level.connect(_on_next_level)
	SignalManager.player_dead.connect(_on_player_dead)
	load_high_score()


func _score_screen() -> void: 
		get_tree().change_scene_to_packed.call_deferred(END_SCREEN)


func _reset_level() -> void:
	lives -= 1
	if lives <= 0:
		save_high_score()
		_score_screen()
		return
	current_score = high_score
	get_tree().change_scene_to_packed(LEVELS[current_level])


func _on_next_level() -> void:
	load_next_level()


func _on_player_dead() -> void:
	await get_tree().create_timer(wait_time_to_reset_level).timeout
	_reset_level()
