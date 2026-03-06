extends Control

@onready var lives_label: Label = $MarginContainer/VBoxContainer/LivesLabel
@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel


func _ready() -> void:
	SignalManager.score_increase.connect(_on_score_label_score_increase)
	lives_label.text = "Lives: " + str(GameManager.lives - 1)
	_on_score_label_score_increase()


func _on_score_label_score_increase() -> void:
	score_label.text = "Score: " + str(GameManager.current_score)
