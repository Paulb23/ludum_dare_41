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
	if ($AnimationPlayer.current_animation == "shoot" && $AnimationPlayer.is_playing()):
		return

	if (!in_cover):
		if ($AnimationPlayer.current_animation != "walk"):
			$AnimationPlayer.play("walk")
		position += Vector2(100, 0) * delta
		if (position.x > Globals.screen_width):
			emit_signal("load_next")
	else:
		if ($AnimationPlayer.current_animation != "cover"):
			$AnimationPlayer.play("cover")

func shoot():
	$AnimationPlayer.play("shoot")
	$shoot.play()

func _area_entered(other):
	in_cover = true
	emit_signal("reached_cover", other)

func _area_exited(other):
	in_cover = false