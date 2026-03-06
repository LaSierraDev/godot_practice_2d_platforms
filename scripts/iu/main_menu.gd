extends Control

@onready var start_button: Button = $VBoxContainer/ButtonVBC/StartButton
@onready var sfx_button: Button = $VBoxContainer/ButtonVBC/SFXButton
@onready var music_button: Button = $VBoxContainer/ButtonVBC/MusicButton
@onready var quit_button: Button = $VBoxContainer/ButtonVBC/QuitButton
@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	sfx_button.pressed.connect(_on_sfx_button_pressed)
	music_button.pressed.connect(_on_music_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	SignalManager.score_increase.connect(_on_score_label_score_increase)

	start_button.grab_focus()

func _process(_delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	GameManager.load_next_level()


func _on_sfx_button_pressed() -> void:
	pass


func _on_music_button_pressed() -> void:
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_score_label_score_increase() -> void:
	high_score_label.text = "High score: " + str(GameManager.high_score)
