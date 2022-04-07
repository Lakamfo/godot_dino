extends KinematicBody2D

var velocity = Vector2()

export var type = {
	"SMALL":{
		"texture":preload("res://assets/sprites/cactus_small.png"),
		"offstep":34,
		"count":6,
		"w":34,
		"h":73,
		"y_offset":-36.5
	},
	"BIG":{
		"texture":preload("res://assets/sprites/cactus.png"),
		"offstep":50,
		"count":4,
		"w":50,
		"h":100,
		"y_offset":-48
	}
}

onready var sprite = $cactus_sprite
onready var collision = $collision

func _ready() -> void:
	var atlas = AtlasTexture.new()
	var _type = type.get(type.keys()[randi() % type.keys().size()])
	atlas.atlas = _type.texture
	atlas.region = Rect2(Vector2(_type.offstep * randi() % _type.count,0),Vector2(_type.w,_type.h))
	sprite.texture = atlas
	
	for i in get_children():
		i.position.y = _type.y_offset

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
