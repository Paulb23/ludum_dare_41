extends Area2D

var dictionary = preload("res://typer/dictionary.gd")

var points
var word

var dead

func _ready():
	dead = false
	points = 10
	word = dictionary.get_easy_word()
	while (!get_parent().add_word(word, self)):
		word = dictionary.get_easy_word()

	$word.text = word

func kill():
	dead = true
	$word.hide()
	$AnimationPlayer.play("dead")

func get_points():
	return points