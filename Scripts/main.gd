extends Node2D
@onready var spawn_location: PathFollow2D = $SpawnPath/SpawnLocation
var enemy = preload("res://Scenes/enemy.tscn")


func _on_mob_spawn_timer_timeout():
	var enemy_spawn = enemy.instantiate()
	enemy_spawn.add_to_group("enemy")
	var enemy_spawn_location = spawn_location
	enemy_spawn_location.progress_ratio = randf()
	
	enemy_spawn.initialize(enemy_spawn_location.position)
	enemy_spawn.on_death.connect($ScreenCanvas._on_enemy_death)
	add_child(enemy_spawn)

	
