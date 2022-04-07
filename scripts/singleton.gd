extends Node

export var SCROLL_SPEED = -500
export (bool) var started = true

var score : float = 0
var speed : float = 1
var high_score : int = 0
var previous_score : int = 0

onready var ui

signal new_high

func _ready() -> void:
	randomize()

func _physics_process(delta: float) -> void:
	if started:
		score += 0.1 * speed
		speed += delta / 50
		speed = clamp(speed,1,5)
	
	if score > previous_score + 100:
		previous_score += 100
		emit_signal("new_high")
	
	if score > high_score:
		high_score = int(score)
