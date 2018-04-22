extends Control


func _ready():
	$menu/endless.connect("pressed", self, "_endless")
	$menu/quit.connect("pressed", self, "_quit")
	$sfx/menu_theme.play()

	$vol/music_vol.connect("value_changed", self, "_music_vol_changed")
	$vol/music_vol.value = AudioServer.get_bus_volume_db(abs(AudioServer.get_bus_index("music")))

	$vol/sfx_vol.connect("value_changed", self, "_sfx_vol_changed")
	$vol/sfx_vol.value = AudioServer.get_bus_volume_db(abs(AudioServer.get_bus_index("Sfx")))

func _music_vol_changed(val):
	AudioServer.set_bus_volume_db(abs(AudioServer.get_bus_index("music")), val)

func _sfx_vol_changed(val):
	AudioServer.set_bus_volume_db(abs(AudioServer.get_bus_index("Sfx")), val)

func _endless():
	$sfx/menu_click.play()
	yield($sfx/menu_click, "finished")
	Globals.set_scene("res://endless_mode.tscn")

func _quit():
	$sfx/menu_click.play()
	yield($sfx/menu_click, "finished")
	get_tree().quit()