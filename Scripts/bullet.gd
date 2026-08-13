extends CharacterBody2D

var speed = 800.0

func start(_position, _rotation):
	position = _position
	rotation = _rotation
	velocity = Vector2(speed, 0).rotated(rotation)


func _physics_process(delta: float):
	move_and_collide(velocity * delta)


func _on_body_entered(body: Node2D):
	if body.is_in_group("enemy"):
		body.take_damage(15)
		queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
