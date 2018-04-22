extends "res://game.gd"

var parts = [
	preload("res://level_parts/flat_open_space.tscn"),
	preload("res://level_parts/flat_open_space_v2.tscn"),
	preload("res://level_parts/flat_open_space_v3.tscn"),
	preload("res://level_parts/wall_open_space_v3.tscn"),
	preload("res://level_parts/wall_open_space_v2.tscn")
]

var parts_completed = 0
var world
var current_part

var slowest_spawn_speed = 3
var min_spawn = 1
var max_spawn = 5

func _ready():
	world =	$world
	_load_next()
	player.connect("load_next", self, "_load_next")

func _load_next():
	parts_completed +=1
	player.position.x = 0;
	if (current_part):
		current_part.queue_free()
	var parts_max = parts_completed
	if (parts_completed >= parts.size()):
		parts_max = parts.size()
	current_part = parts[int(rand_range(0, parts_max))].instance()
	slowest_spawn_speed -= 0.1
	if (slowest_spawn_speed < 1.5):
		slowest_spawn_speed = 1
	min_spawn += 1
	max_spawn += 2

	current_part.slowest_spawn_speed = slowest_spawn_speed
	current_part.min_spawn = min_spawn
	current_part.max_spawn = max_spawn
	world.add_child(current_part)
