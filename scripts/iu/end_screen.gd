extends Control

@onready var score_label: Label = $PanelContainer/MarginContainer/VBoxContainer/ScoreLabel
@onready var return_button: Button = $PanelContainer/MarginContainer/VBoxContainer/ReturnButton


func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)
	score_label.text = "Your Score: " + str(GameManager.current_score)


func _on_return_button_pressed() -> void:
	GameManager._reset_game()
