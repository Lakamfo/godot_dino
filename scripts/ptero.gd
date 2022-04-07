extends KinematicBody2D

var velocity = Vector2()

onready var sprite = $ptero_sprite
onready var collision = $collision

func _process(_delta: float) -> void:
	if not singleton.started:
		return
	velocity.x = singleton.SCROLL_SPEED * singleton.speed
	velocity = move_and_slide(velocity)

func player_entered(body: Node) -> void:
	if body.name == "dino":
		body.die()

func visibility_notifer_screen_exited() -> void:
	queue_free()
