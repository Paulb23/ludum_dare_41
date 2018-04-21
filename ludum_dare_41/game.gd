extends Node2D

var player
var typer

var cover_complete = false
var player_cover

func _ready():
	player = $player
	player.connect("reached_cover", self, "_player_reached_cover")

	typer = $typer
	typer.connect("request_word", self, "_request_word")
	typer.connect("word_complete", self, "_word_complete")

func _physics_process(delta):
	if cover_complete:
		player_cover.position = Vector2(-100,-100)
		player_cover = null
		cover_complete = false
	pass

func _player_reached_cover(other):
	cover_complete = false
	player_cover = other
	player_cover.connect("cover_completed", self, "_cover_completed");

func _request_word(letter):
	if (!player_cover):
		return
	typer.set_current_word(player_cover.get_word(letter))

func _word_complete(word):
	if (!player_cover):
		return
	player_cover.word_complete(word)

func _cover_completed():
	cover_complete = true