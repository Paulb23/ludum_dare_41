extends Control


func _ready():
	$menu/endless.connect("pressed", self, "_endless")

func _endless():
	Globals.set_scene("res://endless_mode.tscn")