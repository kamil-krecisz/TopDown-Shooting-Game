extends Node2D
@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer

@onready var res_option_button: OptionButton = $SettingsLayer/Panel/VBoxContainer/ResOptionButton
@onready var mode_option_button: OptionButton = $SettingsLayer/Panel/VBoxContainer/ModeOptionButton

var resolutions = [Vector2i(1920,1080), Vector2i(1600,900), Vector2i(1280,720), Vector2i(1152,648)] # Available resolutions to set

func _ready():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var res = config.get_value("screen", "resolution")
		var mode = config.get_value("screen", "mode")
		DisplayServer.window_set_size(res)
		DisplayServer.window_set_mode(mode)


func _on_play_button_pressed():
	audio_player.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_settings_button_pressed():
	audio_player.play()
	if $SettingsLayer/Panel.visible == false:
		$SettingsLayer/Panel.visible = true
		$AnimationPlayer.play("settings_animation")
	elif $SettingsLayer/Panel.visible == true:
		$AnimationPlayer.play_backwards("settings_animation")
		await get_tree().create_timer(0.25).timeout
		$SettingsLayer/Panel.visible = false


func _on_exit_button_pressed():
	audio_player.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()


func _on_close_button_pressed():
	audio_player.play()
	$AnimationPlayer.play_backwards("settings_animation")
	await get_tree().create_timer(0.25).timeout
	$SettingsLayer/Panel.visible = false


func _on_apply_button_pressed():
	audio_player.play()
	var res = resolutions[res_option_button.selected]
	var mode = mode_option_button.selected
	
	DisplayServer.window_set_size(res)
	DisplayServer.window_set_mode(mode)
	
	var config = ConfigFile.new()
	config.set_value("screen", "resolution", res)
	config.set_value("screen", "mode", mode)
	
	config.save("user://settings.cfg")
