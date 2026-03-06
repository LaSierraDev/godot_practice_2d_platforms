extends Control

@onready var score_label: Label = $PanelContainer/MarginContainer/VBoxContainer/ScoreLabel
@onready var return_button: Button = $PanelContainer/MarginContainer/VBoxContainer/ReturnButton
@onready var end_label: Label = $PanelContainer/MarginContainer/VBoxContainer/EndLabel


func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)
	SignalManager.score_increase.connect(_on_score_label_score_increase)
	return_button.grab_focus()
	_update_end_label()
	score_label.text = "Your Score: " + str(GameManager.current_score)


func _update_end_label() -> void:
	if GameManager.lives <= 0:
		end_label.text = "GAME OVER"
	else: end_label.text = "CONGRATULATIONS"


func _on_return_button_pressed() -> void:
	GameManager.restart_game()


func _on_score_label_score_increase() -> void:
	score_label.text = "Score: " + str(GameManager.high_score)
