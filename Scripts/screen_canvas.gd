extends CanvasLayer
@onready var stamina_bar: ProgressBar = $StaminaBar
@onready var money_label: Label = $MoneyLabel
var money_amount = 0


func _on_player_stamina_change(new_stamina_value):
	stamina_bar.value = new_stamina_value


func _on_enemy_death(value):
	money_amount += value
	money_label.text = "Money: " + str(money_amount)
