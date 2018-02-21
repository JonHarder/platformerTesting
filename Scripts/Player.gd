extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 30
const ACCELERATION = 30
const MAX_SPEED = 250
const JUMP_HEIGHT = -600

var speed = Vector2()
var sprite;


func _ready():
	sprite = $Sprite;

func _process(delta):
	var friction = false
	speed.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
		sprite.play("Run")
		speed.x = min(speed.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		sprite.flip_h = true
		sprite.play("Run")
		speed.x = max(speed.x - ACCELERATION, -MAX_SPEED)
	else:
		friction = true
		sprite.play("Idle")
		
	speed.x = clamp(speed.x, -MAX_SPEED, MAX_SPEED)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			speed.y = JUMP_HEIGHT
		if friction:
			speed.x = lerp(speed.x, 0, 0.2)
	else:
		if friction:
			speed.x = lerp(speed.x, 0, 0.05)
		if speed.y < 0:
			sprite.play("Jump")
		else:
			sprite.play("Fall")

	
	speed = move_and_slide(speed, UP)
