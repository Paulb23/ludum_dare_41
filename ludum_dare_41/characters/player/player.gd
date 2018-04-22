extends KinematicBody2D

var hit_recently = false

signal load_next

var life = 3
var area_detector
var shader

signal hit
signal reached_cover
var in_cover

func _ready():
	add_to_group("player")
	area_detector = $area_detector
	area_detector.connect("area_entered", self, "_area_entered")
	area_detector.connect("area_exited", self, "_area_exited")
	in_cover = false
	hit_recently = false

	$hit_timer.connect("timeout", self, "_hit_timer")

	shader = $sprite.get_material()
	shader.set_shader_param("fade",false)

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
	if (!other.has_method("is_player_cover") || !other.is_player_cover()):
		return
	in_cover = true
	emit_signal("reached_cover", other)

func _area_exited(other):
	in_cover = false

func shot(other):
	var chance_to_hit = other.chance_to_hit
	if (hit_recently):
		chance_to_hit = -100

	var hit = (rand_range(0, 100) + chance_to_hit) > 100
	if (hit):
		play_sound($hit)
		hit_recently = true
		$hit_timer.start()
		shader.set_shader_param("fade",true)
		life -= 1;
		emit_signal("hit", life)
	else:
		play_sound($miss)

func _get_life():
	return life

func _hit_timer():
	hit_recently = false
	shader.set_shader_param("fade",false)

func play_sound(sound):
	$sound_timer.start()
	yield($sound_timer, "timeout")
	sound.play()