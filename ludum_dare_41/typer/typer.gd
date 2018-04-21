extends Control

var dictionary = preload("res://typer/dictionary.gd")

var background_color = Color(0.183594, 0.024384, 0.024384)
var defualt_color = Color(1,1,1)
var completed_color = Color(0,1,0)

var current_char
var current_word
var current_word_size

var word

func _ready():
	randomize()
	word = $word
	load_next_word()

func _unhandled_input(event):
	if (!event.is_pressed()):
		return

	var key_pressed = null
	if (event.shift):
		key_pressed = OS.get_scancode_string(event.scancode)
	else:
		key_pressed = OS.get_scancode_string(event.scancode).to_lower()

	if (key_pressed == current_word[current_char]):
		current_char += 1

		word.clear()
		word.push_color(completed_color)
		word.add_text(current_word.substr(0, current_char))
		word.push_color(defualt_color)
		word.add_text(current_word.substr(current_char, current_word_size))

	if (current_char == current_word_size):
		load_next_word()

func load_next_word():
	current_word = dictionary.get_easy_word()
	current_word_size = current_word.length()
	current_char = 0
	word.clear()
	word.push_color(defualt_color)
	word.add_text(current_word)