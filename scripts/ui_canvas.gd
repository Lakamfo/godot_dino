extends CanvasLayer

onready var hi_score = $scores/hi
onready var score = $scores/score

onready var dead_screen = $dead_screen
onready var restart_button = $dead_screen/restart_button

func _ready() -> void:
	singleton.ui = self

func _process(_delta: float) -> void:
	score.text = "SCORE: " + str(int(singleton.score))
	hi_score.text = "HI: " + str(singleton.high_score)

func show_gm_screen():
	dead_screen.show()
	restart_button.disabled = false

func restart_down() -> void:
	singleton.started = true
	if singleton.score > singleton.high_score:
		singleton.high_score = int(singleton.score)
	singleton.score = 0
	if get_tree().reload_current_scene() != OK:
		print("check 'game' scene for errors")
