extends CharacterBody2D

const GRAVITY = 1200
const JUMP_SPEED = 600
const ACCELERATION = 20000.0
const MAX_VELOCITY = 300000
const FRICTION = 4000.0

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_SPEED
		
	if Input.is_action_just_released("jump"):
		velocity.y = velocity.y / 4
	
	if direction != 0:
		velocity.x = move_toward(0, MAX_VELOCITY * direction, ACCELERATION * delta)
	else: 
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	velocity.y += GRAVITY * delta
	
	move_and_slide()
