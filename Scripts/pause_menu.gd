extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer

func _process(_delta):
	if Input.is_action_just_pressed("Esc_down") && get_tree().paused == false: # Opening the pause menu
		pause()
	elif Input.is_action_just_pressed("Esc_down") && get_tree().paused == true: # Closing the pause menu
		resume()


func _ready():
	visible = false
	buttons_disable_state(true)


func buttons_disable_state(state: bool):
	$PanelContainer/VBoxContainer/ResumeButton.disabled = state
	$PanelContainer/VBoxContainer/MainMenuButton.disabled = state
	$PanelContainer/VBoxContainer/ExitButton.disabled = state

func pause():
	buttons_disable_state(false)
	visible = true
	animation_player.play("pause_resume")
	get_tree().paused = true



func resume():
	buttons_disable_state(true)
	get_tree().paused = false
	animation_player.play_backwards("pause_resume")
	await get_tree().create_timer(0.2).timeout






func _on_resume_button_pressed():
	audio_player.play()
	await get_tree().create_timer(0.05).timeout
	resume()




func _on_main_menu_button_pressed():
	audio_player.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")




func _on_exit_button_pressed():
	audio_player.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
