extends CharacterBody2D

@onready var health_bar = $HealthBar

var player
var direction
var speed = 6500.0
var health = 100
var worth = 100

signal on_death(value)


func _ready():
	player = get_tree().get_first_node_in_group("player")
	print(player)
	
func _physics_process(delta):
	health_bar.value = health
	if health < 100:
		health_bar.visible = true
	if health == 0:
		on_death.emit(worth)
		queue_free()
	
	
	direction = player.global_position - global_position
	velocity = direction.normalized() * delta * speed
	
	move_and_slide()
