extends Control

@onready var start_button: Button = $VBoxContainer/ButtonVBC/StartButton
@onready var sfx_button: Button = $VBoxContainer/ButtonVBC/SFXButton
@onready var music_button: Button = $VBoxContainer/ButtonVBC/MusicButton
@onready var quit_button: Button = $VBoxContainer/ButtonVBC/QuitButton
@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	sfx_button.pressed.connect(_on_sfx_button_pressed)
	music_button.pressed.connect(_on_music_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	start_button.focus_entered.connect(_on_button_focus_entered)
	sfx_button.focus_entered.connect(_on_button_focus_entered)
	music_button.focus_entered.connect(_on_button_focus_entered)
	quit_button.focus_entered.connect(_on_button_focus_entered)
	
	start_button.mouse_entered.connect(_on_button_focus_entered)
	sfx_button.mouse_entered.connect(_on_button_focus_entered)
	music_button.mouse_entered.connect(_on_button_focus_entered)
	quit_button.mouse_entered.connect(_on_button_focus_entered)
	
	start_button.grab_focus()
	
	AudioManager.reset_audio() 
	
	SignalManager.score_increase.connect(_on_score_label_score_increase)
	_update_high_score()


func _update_high_score() -> void:
	high_score_label.text = "High score: " + str(GameManager.dataio.load_data())


func _button_pressed_sound() -> void:
	AudioManager.play_sfx(audio_stream_player, AudioManager.BUTTON_FOCUS)


func _on_off_text_state(is_active: bool) -> String:
	var state: String = "on"
	if not is_active: 
		state = "off"
	return state 


func _on_start_button_pressed() -> void:
	_button_pressed_sound()
	await get_tree().create_timer(0.1).timeout
	GameManager.load_next_level()


func _on_sfx_button_pressed() -> void:
	AudioManager.toggle_sfx()
	_button_pressed_sound()
	sfx_button.text = "SFX: " + _on_off_text_state(AudioManager.is_sfx_active)


func _on_music_button_pressed() -> void:
	AudioManager.toggle_music()
	_button_pressed_sound()
	music_button.text = "Music: " + _on_off_text_state(AudioManager.is_music_active)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_score_label_score_increase() -> void:
	_update_high_score()


func _on_button_focus_entered() -> void:
	_button_pressed_sound()
