extends Node2D


func _on_retry_button_pressed():
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
