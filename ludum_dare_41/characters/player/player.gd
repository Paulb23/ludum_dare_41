extends KinematicBody2D

signal load_next

var area_detector

signal reached_cover
var in_cover

func _ready():
	area_detector = $area_detector
	area_detector.connect("area_entered", self, "_area_entered")
	area_detector.connect("area_exited", self, "_area_exited")
	in_cover = false

func _physics_process(delta):
	if (!in_cover):
		position += Vector2(100, 0) * delta
		if (position.x > Globals.screen_width):
			emit_signal("load_next")

func _area_entered(other):
	in_cover = true
	emit_signal("reached_cover", other)

func _area_exited(other):
	in_cover = false