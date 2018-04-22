extends "res://level_parts/level_part.gd"

var spawn_count = 0

var slowest_spawn_speed = 3
var min_spawn = 1
var max_spawn = 5

var started = false
var bandit = preload("res://characters/cowboys/cowboy.tscn")

func _ready():
	$spawn_timer.connect("timeout", self, "spawn_next")
	$spawn_timer.wait_time = rand_range(0.5, slowest_spawn_speed)
	spawn_count = round(rand_range(min_spawn, max_spawn))

func spawn_next():
	if (spawn_count > 0):
		var new_bandit = bandit.instance()
		new_bandit.position = Vector2(275, 74)
		new_bandit.start()
		add_child(new_bandit)
		spawn_count -= 1
		$spawn_timer.start()

func word_complete(word):
	if (!started):
		started = true
		$spawn_timer.wait_time = rand_range(0.5, slowest_spawn_speed)
		$spawn_timer.start()
	if (spawn_count > 0 && level_words.size() <= 1):
		spawn_next()

	return .word_complete(word)