extends Position2D

var cactus_scene = preload("res://scenes/cactus.tscn")
var pretodactyl = preload("res://scenes/pterodactyl.tscn")
onready var spawn_timer = $cactus_timer
onready var ptero_timer = $ptero_timer

onready var cactus_pos = $cactus_pos
onready var ptero_pos = $ptero_pos

func _physics_process(_delta: float) -> void:
	if singleton.started:
		if spawn_timer.is_stopped():
			spawn_timer.wait_time = 3 / singleton.speed
			spawn_timer.start()
		if ptero_timer.is_stopped() and singleton.score > 500:
			ptero_timer.wait_time = rand_range(2,5) / singleton.speed
			ptero_timer.start()

func spawn_timer_timeout() -> void:
	print_debug("spawn cactus")
	if singleton.started:
		var instance = cactus_scene.instance()
		cactus_pos.add_child(instance)
		spawn_timer.start()

func ptero_timer_timeout() -> void:
	print_debug("spawn pterodactyl")
	if singleton.started:
		var instance = pretodactyl.instance()
		ptero_pos.add_child(instance)
		ptero_timer.start()
