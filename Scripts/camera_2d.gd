extends Camera2D


@export var random_strength = 5.0
var shake_fade = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength = 0.0

func apply_shake():
	shake_strength = random_strength
	
func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade*delta)
		offset = randomOffset()
	
func randomOffset():
	return Vector2(rng.randf_range(-shake_strength,shake_strength), rng.randf_range(-shake_strength,shake_strength))


func _on_player_taking_damage():
	print(rng.randf_range(-shake_strength,shake_strength))
	apply_shake()
