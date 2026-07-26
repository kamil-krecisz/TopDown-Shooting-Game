extends CharacterBody2D

var speed = 500.0

func start(_position, _rotation):
	position = _position
	rotation = _rotation
	velocity = Vector2(speed, 0).rotated(rotation)


func _physics_process(delta: float) -> void:
	
	move_and_collide(velocity * delta)
