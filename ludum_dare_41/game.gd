extends Node2D


var words_completed

var failed
var score_words_completed
var words_util_next_multi
var score_multiplyer
var score

var player
var typer

var cover_complete = false
var player_cover

func _ready():
	failed = false
	score_words_completed = 0
	words_completed = 0
	score_multiplyer = 1
	words_util_next_multi = 1
	score = 0

	player = $player
	player.connect("reached_cover", self, "_player_reached_cover")

	typer = $typer
	typer.connect("request_word", self, "_request_word")
	typer.connect("word_complete", self, "_word_complete")
	typer.connect("invalid_key", self, "_invalid_key")
	typer.set_points(score)
	typer.set_multiplyer(score_multiplyer)

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
	score_words_completed += 1
	words_completed += 1

	if (score_words_completed >= words_util_next_multi && !failed):
		$sfx/inc_score_multi.play()
		score_multiplyer += 1
		words_util_next_multi = pow(score_multiplyer, 2)

	failed = false
	var points = player_cover.word_complete(word)
	score += (points * score_multiplyer)
	typer.set_points(score)
	typer.set_multiplyer(score_multiplyer)

	player.shoot()

func _cover_completed():
	cover_complete = true

func _invalid_key():
	failed = true
	if (score_multiplyer == 1):
		return
	score_words_completed = 0
	score_multiplyer = 1
	words_util_next_multi = pow(score_multiplyer, 2)
	typer.set_multiplyer(score_multiplyer)
	$sfx/dec_score_multi.play()