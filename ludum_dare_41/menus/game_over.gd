extends Control


func _ready():
	$menu/continue.grab_focus()
	$menu/continue.connect("pressed", self, "_continue")
	$menu/menu.connect("pressed", self, "_menu")
	$menu/quit.connect("pressed", self, "_quit")
	$sfx/game_over_theme.play()

	$stats/points.text = String(Globals.get("points"))
	$stats/acc.text = String(Globals.get("acc")) + "%"
	$stats/wpm_stat.text = String(Globals.get("words"))

func _unhandled_input(event):
	if (!event.is_pressed() || !event is InputEventKey || event.scancode != KEY_ESCAPE || event.is_echo()):
		return

	if (get_tree().paused):
		_continue()
	else:
		rect_position = Vector2(0, 0)
		get_tree().paused = true

func _continue():
	$sfx/menu_click.play()
	yield($sfx/menu_click, "finished")
	get_tree().paused = false
	Globals.set_scene("res://endless_mode.tscn")

func _menu():
	$sfx/menu_click.play()
	yield($sfx/menu_click, "finished")
	get_tree().paused = false
	Globals.set_scene("res://menus/main_menu.tscn")

func _quit():
	$sfx/menu_click.play()
	yield($sfx/menu_click, "finished")
	get_tree().quit()