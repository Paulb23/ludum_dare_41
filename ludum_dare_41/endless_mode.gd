extends "res://game.gd"

var parts = [
	preload("res://level_parts/flat_open_space.tscn")
]

var world
var current_part

func _ready():
	world =	$world
	current_part = parts[0].instance()
	world.add_child(current_part)
	player.connect("load_next", self, "_load_next")

func _load_next():
	player.position.x = 0;
	current_part.queue_free()
	current_part = parts[0].instance()
	world.add_child(current_part)
