extends Node

var level_words = {}

func _ready():
	pass

func get_word(letter):
	for word in level_words.keys():
		if word.begins_with(letter):
			return word
	return null

func word_complete(word):
	var points = level_words[word].get_points()
	level_words[word].queue_free()
	level_words.erase(word)
	return points

func add_word(new_word, object):
	if (level_words.has(new_word)):
		return false
	level_words[new_word] = object
	return true