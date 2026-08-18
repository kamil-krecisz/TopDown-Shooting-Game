extends CharacterBody2D

@onready var health_bar = $HealthBar

var player
var direction
var speed = 7500.0
var rotation_speed = 3.5
var health = 100
@export var worth = 25

var can_attack = true

signal on_death(value)

func initialize(starting_position):
	position = starting_position
	


func take_damage(value: int):
	health -= value
	$AudioPlayer.play()

func _ready():
	
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta):
	health_bar.value = health
	if health < 100:
		health_bar.visible = true
	if health <= 0:
		on_death.emit(worth)
		queue_free()
	
	
	$Sprite2D.rotation = lerp_angle($Sprite2D.rotation ,(player.global_position - global_position).angle(), rotation_speed*delta) # rotating enemy's sprite so that it faces the player
	
	
	direction = player.global_position - global_position
	velocity = direction.normalized() * delta * speed
	
	move_and_slide()


func _on_attack_body_entered(body):
	if body.is_in_group("player") && can_attack == true:
		attack(body)
	elif body.is_in_group("player") && can_attack == false:
		can_attack = true
func attack(body):
	body.take_damage(10)
	await get_tree().create_timer(2).timeout
	_on_attack_body_entered(body)


func _on_attack_body_exited(body):
	if body.is_in_group("player"):
		can_attack = false
