extends KinematicBody2D

const JUMP_HIGH = 400 #per second

onready var animation_sprite = $animation_sprite
onready var gravity_timer = $gravity_enable

onready var jump_sound = $jump_sound
onready var death_sound = $death_sound
onready var score_sound = $score_sound

onready var collision_stay = $stay_collision
onready var collision_sit = $sit_collision

var velocity = Vector2()
var can_jump = true
var jumping = false
var gravity_apply = false
var move_and_slide_return 

func _ready() -> void:
	print_debug(singleton.connect("new_high",self,"_score_new_high"))
	animation_sprite.play("idle")

func _physics_process(delta: float) -> void:
	if singleton.started != true:
		return
	
	if is_on_floor():
		can_jump = true
		gravity_apply = false
		velocity = Vector2()
		jumping = false
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jumping = true
		jump_sound.play()
	if Input.is_action_just_released("ui_accept") and jumping != false:
		jumping = false
	
	if Input.is_action_pressed("ui_down"):
		animation_sprite.play("run_down")
		gravity_apply = true
		apply_gravity(delta,8)
		collision_sit.disabled = false
		collision_stay.disabled = true
	else:
		animation_sprite.play("run")
		collision_sit.disabled = true
		collision_stay.disabled = false
	
	if jumping and can_jump:
		velocity.y = -JUMP_HIGH
		if gravity_timer.is_stopped():
			gravity_timer.start()
	
	if Input.is_action_just_released("ui_accept"):
		gravity_apply = true
	
	velocity.y = clamp(velocity.y,-JUMP_HIGH,JUMP_HIGH * 2)
	
	apply_gravity(delta,6)
	
	move_and_slide_return = move_and_slide(velocity,Vector2.UP)
	
	

func gravity_enable() -> void:
	gravity_apply = true
	can_jump = false

func apply_gravity(delta:float,speed:int):
	if gravity_apply:
		velocity.y += (JUMP_HIGH * speed) * delta

func die():
	singleton.started = false
	death_sound.play()
	animation_sprite.play("dead")
	singleton.ui.show_gm_screen()

func _score_new_high():
	score_sound.play()
