extends Node

var level_words = {}

func _ready():
	pass

func get_word(letter):
	var final_word = null
	var current_x = 10000
	for word in level_words.keys():
		if word.begins_with(letter):
			if (level_words[word].position.x < current_x):
				final_word = word
				current_x = level_words[word].position.x
	return final_word

func word_complete(word):
	var points = level_words[word].get_points()
	level_words[word].kill()
	level_words.erase(word)
	return points

func add_word(new_word, object):
	if (level_words.has(new_word)):
		return false
	level_words[new_word] = object
	return true