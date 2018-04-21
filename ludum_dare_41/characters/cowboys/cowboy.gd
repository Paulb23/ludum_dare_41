extends Area2D

var dictionary = preload("res://typer/dictionary.gd")

var points
var word

func _ready():
	points = 10
	word = dictionary.get_easy_word()
	while (!get_parent().add_word(word, self)):
		word = dictionary.get_easy_word()

	$word.text = word

func get_points():
	return points