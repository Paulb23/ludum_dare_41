extends Control


func _ready():
	rect_position = Vector2(-1000, -1000)
	$menu/continue.grab_focus()
	$menu/continue.connect("pressed", self, "_continue")
	$menu/menu.connect("pressed", self, "_menu")
	$menu/quit.connect("pressed", self, "_quit")

	$vol/music_vol.connect("value_changed", self, "_music_vol_changed")
	$vol/music_vol.value = AudioServer.get_bus_volume_db(abs(AudioServer.get_bus_index("music")))

	$vol/sfx_vol.connect("value_changed", self, "_sfx_vol_changed")
	$vol/sfx_vol.value = AudioServer.get_bus_volume_db(abs(AudioServer.get_bus_index("Sfx")))

func _music_vol_changed(val):
	AudioServer.set_bus_volume_db(abs(AudioServer.get_bus_index("music")), val)

func _sfx_vol_changed(val):
	AudioServer.set_bus_volume_db(abs(AudioServer.get_bus_index("Sfx")), val)

func _unhandled_input(event):
	if (!event.is_pressed() || !event is InputEventKey || event.scancode != KEY_ESCAPE || event.is_echo()):
		return

	if (get_tree().paused):
		_continue()
	else:
		rect_position = Vector2(0, 0)
		get_tree().paused = true

func _continue():
	rect_position = Vector2(-1000, -1000)
	$sfx/menu_click.play()
	yield($sfx/menu_click, "finished")
	get_tree().paused = false

func _menu():
	$sfx/menu_click.play()
	yield($sfx/menu_click, "finished")
	get_tree().paused = false
	Globals.set_scene("res://menus/main_menu.tscn")

func _quit():
	$sfx/menu_click.play()
	yield($sfx/menu_click, "finished")
	get_tree().quit()