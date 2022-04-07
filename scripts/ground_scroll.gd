extends StaticBody2D


onready var ground_1 = $ground_1
onready var ground_2 = $ground_2


func _process(delta: float) -> void:
	if not singleton.started:
		return
	
	ground_1.position.x += (singleton.SCROLL_SPEED * delta) * singleton.speed
	ground_2.position.x += (singleton.SCROLL_SPEED * delta) * singleton.speed
	
	if ground_1.position.x < -1201:
		ground_1.position.x = 3601
	if ground_2.position.x < -1201:
		ground_2.position.x = 3601
