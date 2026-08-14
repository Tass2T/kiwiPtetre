class_name Fox_Rider extends CharacterBody2D

@onready var void_cast: RayCast2D = $VoidCast
@onready var wall_cast: RayCast2D = $WallCast
@onready var vision_collision_shape_2d: CollisionShape2D = $VisionArea2D/VisionCollisionShape2D
@onready var surprise_timer: Timer = $SurpriseTimer

enum STATE {
	PATROL, SUPRISE, CHASE
}

const GRAVITY: float = 4000.0
const MAX_FALLING_SPEED: float = 1900.0
const SPEED: float = 500.0
const CHASE_SPEED: float = 1500
const ACCELERATION: float = 1500.0
const CHASE_ACCELERATION: float = 4500.0
const SURPRISE_TIME: float = 0.5

var direction: float = 1.0
var current_state: STATE = STATE.PATROL

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, MAX_FALLING_SPEED, GRAVITY * delta)
	
	else:	
		if current_state == STATE.PATROL:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
		elif current_state == STATE.CHASE:
			velocity.x = move_toward(velocity.x, direction * CHASE_SPEED, CHASE_ACCELERATION * delta)
			
		if wall_cast.is_colliding() or !void_cast.is_colliding():
			reverse_direction()
			
	
	move_and_slide()
		

func reverse_direction()-> void:
	velocity.x = 0
	direction *= -1
	scale.x *= -1


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and current_state == STATE.PATROL:
		current_state = STATE.SUPRISE
		velocity.x = 0
		surprise_timer.start(SURPRISE_TIME)
		

func _on_surprise_timer_timeout() -> void:
	current_state = STATE.CHASE
