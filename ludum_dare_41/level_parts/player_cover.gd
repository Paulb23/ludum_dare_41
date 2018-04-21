extends Area2D

signal cover_completed

func get_word(letter):
	return get_parent().get_word(letter)

func word_complete(word):
	var points = get_parent().word_complete(word)
	if (get_parent().level_words.size() <= 0):
		emit_signal("cover_completed")
	return points