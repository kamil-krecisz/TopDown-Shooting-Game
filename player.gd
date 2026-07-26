extends CharacterBody2D



var Bullet = preload("res://bullet.tscn")
var mouse_position: Vector2
@export var speed = 20000.0
@export var deceleration = 25.0
var character_direction: Vector2
var b

func _physics_process(delta):
	mouse_position = get_global_mouse_position() - global_position
	rotation = mouse_position.angle()
	character_direction.y = Input.get_axis("W_down","S_down")
	character_direction.x = Input.get_axis("A_down","D_down")
	character_direction = character_direction.normalized()
	
	if character_direction != Vector2.ZERO:
		velocity = character_direction * speed * delta
	if Input.is_action_just_pressed("left_down"): #SHOOTING
		b = Bullet.instantiate()
		get_tree().root.add_child(b)
		b.start($Muzzle.global_position, mouse_position.angle())
	
	
	
	
	
	
	
	velocity = velocity.lerp(Vector2.ZERO, deceleration * delta)
	move_and_slide()
