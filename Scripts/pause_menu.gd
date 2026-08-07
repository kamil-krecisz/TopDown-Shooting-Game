extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer

var money: int = 0

signal upgrade_bought(cost: int, upgrade_strength: float, time)


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
	$ShopButton.disabled = state


func pause():
	buttons_disable_state(false)
	visible = true
	animation_player.play("pause_resume")
	get_tree().paused = true



func resume():
	buttons_disable_state(true)
	shop_state("close")
	get_tree().paused = false
	animation_player.play_backwards("pause_resume")
	await get_tree().create_timer(0.2).timeout
	visible = false

func shop_state(state: String):
	if state == "open":
		$ShopPanel.visible = true
		$ShopPanel/KotletLabel/NomLabel.visible = false
		animation_player.play("open_close_shop")
	elif state == "close":
		animation_player.play_backwards("open_close_shop")
		await get_tree().create_timer(0.25).timeout
		$ShopPanel.visible = false




func _on_resume_button_pressed():
	audio_player.play()
	#await get_tree().create_timer(0.05).timeout
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


func _on_shop_button_pressed():
	audio_player.play()
	if $ShopPanel.visible == false:
		shop_state("open")
	elif $ShopPanel.visible == true:
		shop_state("close")


func _on_buy_pressed():
	audio_player.play()
	if money >= 500:
		money -= 500
		upgrade_bought.emit(500, 2, 60)
	elif money < 500:
		$ShopPanel/KotletLabel/NomLabel.visible = true
		animation_player.play("NomFade")
