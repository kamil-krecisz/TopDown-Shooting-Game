extends CharacterBody2D



var Bullet = preload("res://Scenes/bullet.tscn")
var can_shoot = true

var mouse_position: Vector2
@export var speed = 20000.0
var sprint_value = 1
var can_sprint = true
var upgraded_speed = 1

@export var stamina = 100.0
@export var health = 100.0
var health_regeneration = 1.0

var rotation_speed : float = 7.0

signal stamina_change(new_stamina_value)
signal health_change(new_health_value)
signal taking_damage_shake()

@export var stamina_bar_max = 100

@export var deceleration = 25.0
var character_direction: Vector2
var b

func take_damage(value):
	taking_damage_shake.emit()
	health -= value
	$AudioStreamPlayer2D.play()


func _ready():
	health_change.emit(health)



func _physics_process(delta):
	mouse_position = get_global_mouse_position() - global_position
	rotation = lerp_angle(rotation, mouse_position.angle(), rotation_speed * delta) # Smooth rotation of the player
	character_direction.y = Input.get_axis("W_down","S_down")
	character_direction.x = Input.get_axis("A_down","D_down")
	character_direction = character_direction.normalized()
	
	if Input.is_action_pressed("Shift_down") and can_sprint == true:
		if character_direction != Vector2.ZERO:
			stamina -= 15 * delta
		sprint_value = 1.75
		if stamina <= 0.5:
			sprint_value = 1
			can_sprint = false
			
	else:
		sprint_value = 1
		stamina += 10 * delta
		if stamina >= 15:
			can_sprint = true
			
	stamina = clampf(stamina, 0, stamina_bar_max)
	stamina_change.emit(stamina)
	if character_direction != Vector2.ZERO:
		velocity = character_direction * speed * delta * sprint_value * upgraded_speed
		
	if Input.is_action_just_pressed("left_down") && can_shoot == true: #SHOOTING
		b = Bullet.instantiate()
		get_tree().root.add_child(b)
		b.start($Muzzle.global_position, mouse_position.angle())
		$GunAudioPlayer.play()
		can_shoot = false
		$ShootingTimer.start()

	
	
	
	velocity = velocity.lerp(Vector2.ZERO, deceleration * delta)
	move_and_slide()
	
	# I wrote this at the end of the function because errors were popping up that didn't make sense.
	if health < 100:
		health_change.emit(health)
		health += health_regeneration * delta
	if health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
	health = clampf(health, 0 , 100)


func _on_pause_menu_upgrade_bought(_cost: int, upgrade_strength: float, time):
	$UpgradeTimer.wait_time = time
	upgraded_speed = upgrade_strength
	$UpgradeTimer.start()


func _on_upgrade_timer_timeout():
	upgraded_speed = 1


func _on_shooting_timer_timeout():
	can_shoot = true
