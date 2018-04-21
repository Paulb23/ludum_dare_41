extends Control

signal request_word
signal word_complete

var typing_sound

var defualt_color = Color(1,1,1)
var completed_color = Color(0,1,0)

var current_char
var current_word
var current_word_size

var word

func _ready():
	word = $word
	typing_sound = $typing

func _unhandled_input(event):
	if (!event.is_pressed() || !event is InputEventKey):
		return

	var key_pressed = null
	if (event.shift):
		key_pressed = OS.get_scancode_string(event.scancode)
	else:
		key_pressed = OS.get_scancode_string(event.scancode).to_lower()


	if (current_word == null && key_pressed != null):
		emit_signal("request_word", key_pressed)
		if (current_word == null):
			return

	if (key_pressed == current_word[current_char]):
		typing_sound.play()
		current_char += 1

		word.clear()
		word.push_color(completed_color)
		word.add_text(current_word.substr(0, current_char))
		word.push_color(defualt_color)
		word.add_text(current_word.substr(current_char, current_word_size))

	if (current_char == current_word_size):
		emit_signal("word_complete", current_word)
		current_word = null
		current_char = 0
		word.clear()

func set_current_word(new_word):
	current_word = new_word

	current_char = 0
	word.clear()
	if (new_word == null):
		current_word_size = 0
	else:
		current_word_size = new_word.length()
		word.push_color(defualt_color)
		word.add_text(new_word)
