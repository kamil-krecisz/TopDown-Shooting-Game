extends Node2D
@onready var spawn_location: PathFollow2D = $SpawnPath/SpawnLocation
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var enemy = preload("res://Scenes/enemy.tscn")



signal which_wave(which: int)

var can_check = false
var time_between_waves = 10

var wave = 0
var wave_count = 5
var enemy_count = 10

func _ready():
	next_wave()

func _process(_delta):
	await get_tree().create_timer(11).timeout
	if get_tree().get_node_count_in_group("enemy") == 0 && can_check == true:
		next_wave()

func next_wave():
	can_check = false
	wave += 1
	await get_tree().create_timer(time_between_waves).timeout
	which_wave.emit(wave)
	animation_player.play("WaveIdentifierAni")
	for enemies in enemy_count:
		spawn_enemy()
		await get_tree().create_timer(2).timeout
	enemy_count += 2
	time_between_waves += 2
	can_check = true

func spawn_enemy():
	var enemy_spawn = enemy.instantiate()
	enemy_spawn.add_to_group("enemy")
	var enemy_spawn_location = spawn_location
	enemy_spawn_location.progress_ratio = randf()
	
	enemy_spawn.initialize(enemy_spawn_location.position)
	enemy_spawn.on_death.connect($ScreenCanvas._on_enemy_death)
	add_child(enemy_spawn)
