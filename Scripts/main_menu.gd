extends Node2D
@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer


func _on_play_button_pressed():
	audio_player.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_settings_button_pressed():
	audio_player.play()
	await get_tree().create_timer(0.05).timeout


func _on_exit_button_pressed():
	audio_player.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
