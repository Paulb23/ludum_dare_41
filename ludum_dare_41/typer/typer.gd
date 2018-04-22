extends Control

signal valid_key
signal invalid_key
signal request_word
signal word_complete

var typing_sound

var defualt_color = Color(1,1,1)
var completed_color = Color(0,1,0)

var current_char
var current_word
var current_word_size

var word
var running = true

func _ready():
	word = $word
	typing_sound = $typing

func _unhandled_input(event):
	if (!running):
		return

	if (!event.is_pressed() || !event is InputEventKey || event.scancode == KEY_ESCAPE):
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
		word.add_text(current_word.substr(0, current_char).to_upper())
		word.push_color(defualt_color)
		word.add_text(current_word.substr(current_char, current_word_size).to_upper())
		emit_signal("valid_key")
	elif (key_pressed != null):
		$typing_incorrect.play()
		emit_signal("invalid_key")

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
		word.add_text(new_word.to_upper())

func set_points(points):
	$points_text.text = String(points)

func set_multiplyer(multiplyer):
	$multiplyer_text.text = "x"+String(multiplyer)

func set_life(life):
	if (life == 3):
		$heart_1.frame = 0
		$heart_2.frame = 0
		$heart_3.frame = 0
	elif (life == 2):
		$heart_1.frame = 0
		$heart_2.frame = 0
		$heart_3.frame = 1
	elif (life == 1):
		$heart_1.frame = 0
		$heart_2.frame = 1
		$heart_3.frame = 1
	elif (life == 0):
		$heart_1.frame = 1
		$heart_2.frame = 1
		$heart_3.frame = 1
