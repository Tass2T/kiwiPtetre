extends CharacterBody2D

const GRAVITY = 1240.0
const JUMP_SPEED = 640.0
const ACCELERATION = 2000.0
const MAX_SPEED = 400.0      
const FRICTION = 4000.0   

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_SPEED
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = velocity.y / 4
	
	if direction != 0:
		velocity.x = move_toward(velocity.x, MAX_SPEED * direction, ACCELERATION * delta)
	else: 
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	move_and_slide()
