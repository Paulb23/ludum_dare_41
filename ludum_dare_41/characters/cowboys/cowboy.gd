extends Area2D

var dictionary = preload("res://typer/dictionary.gd")

export var points = 10
export var can_move = true
export var shoot_delay = 0.5
export var chance_to_hit = 30

var can_start = false
var word

var in_shoot = false
var can_shoot = false

var dead = false

var colision

func _ready():
	connect("area_entered", self, "_area_entered")
	connect("area_exited", self, "_area_exited")

	$shoot_timer.connect("timeout", self, "allow_shooting")
	$shoot_timer.wait_time = shoot_delay

	add_to_group("bandits")
	word = dictionary.get_easy_word()
	while (!get_parent().add_word(word, self)):
		word = dictionary.get_easy_word()

	$word.text = word

func _physics_process(delta):
	if ($AnimationPlayer.current_animation == "shoot" && $AnimationPlayer.is_playing()):
		return

	if (dead || !can_start):
		return

	if (!can_move):
		if ($AnimationPlayer.current_animation != "idle_gun"):
			$AnimationPlayer.play("idle_gun")
		if (can_shoot):
			shoot()
		elif ($shoot_timer.time_left <= 0):
			$shoot_timer.start()
		return

	if (in_shoot && colision && colision.has_method("is_dead")):
		if (colision.is_dead()):
			in_shoot = false

	if (!in_shoot):
		if ($AnimationPlayer.current_animation != "walk"):
			$AnimationPlayer.play("walk")
		position -= Vector2(75, 0) * delta
	else:
		if ($AnimationPlayer.current_animation != "idle_gun"):
			$AnimationPlayer.play("idle_gun")
		if (can_shoot):
			shoot()
		elif ($shoot_timer.time_left <= 0):
			$shoot_timer.start()

func start():
	can_start = true

func _area_entered(other):
	in_shoot = true
	colision = other

func _area_exited(other):
	in_shoot = false

func kill():
	dead = true
	$word.hide()
	$AnimationPlayer.play("dead")

func get_points():
	return points

func shoot():
	can_shoot = false
	$shoot.play()
	$AnimationPlayer.play("shoot")
	get_tree().call_group("player", "shot", self)
	$shoot_timer.wait_time = shoot_delay
	$shoot_timer.start()

func allow_shooting():
	can_shoot = true

func is_dead():
	return dead


