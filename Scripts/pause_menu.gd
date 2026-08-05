extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

func pause():
	visible = true
	animation_player.play("pause_resume")
	get_tree().paused = true

func resume():
	get_tree().paused = false
	animation_player.play_backwards("pause_resume")
	await get_tree().create_timer(0.2).timeout

func _process(_delta):
	if Input.is_action_just_pressed("Esc_down") && get_tree().paused == false: # Opening the pause menu
		pause()
	elif Input.is_action_just_pressed("Esc_down") && get_tree().paused == true: # Closing the pause menu
		resume()

	
