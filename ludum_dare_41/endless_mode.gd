extends "res://game.gd"

var parts = [
	preload("res://level_parts/flat_open_space.tscn"),
	preload("res://level_parts/flat_open_space_v2.tscn")
]

var world
var current_part

func _ready():
	world =	$world
	_load_next()
	player.connect("load_next", self, "_load_next")

func _load_next():
	player.position.x = 0;
	if (current_part):
		current_part.queue_free()
	current_part = parts[int(rand_range(0, parts.size()))].instance()
	world.add_child(current_part)
