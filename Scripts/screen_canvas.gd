extends CanvasLayer
@onready var stamina_bar: ProgressBar = $StaminaBar
@onready var health_bar: ProgressBar = $HealthBar
@onready var money_label: Label = $MoneyLabel
@onready var pause_menu: Node2D = $pause_menu

var money_amount = 0

func update_money(money):
	money_label.text = "Money: " + str(money)

func _process(_delta):
	$TimeLeftBar.value = ($TimeLeftBar/Timer.time_left/60)*100
	if $TimeLeftBar/Timer.time_left <= 0:
		$TimeLeftBar.visible = false


func _on_player_stamina_change(new_stamina_value):
	stamina_bar.value = new_stamina_value


func _on_enemy_death(value):
	money_amount += value
	update_money(money_amount)
	pause_menu.money = money_amount


func _on_player_health_change(new_health_value):
	health_bar.value = new_health_value


func _on_pause_menu_upgrade_bought(cost: int, _upgrade_strength: float, time):
	money_amount -= cost
	update_money(money_amount)
	$TimeLeftBar/Timer.wait_time = time
	$TimeLeftBar.visible = true
	$TimeLeftBar/Timer.start()


func _on_which_wave(which: int):
	$WaveIdentifier.visible = true
	$WaveIdentifier/WaveLabel.text = "WAVE: " + str(which)
