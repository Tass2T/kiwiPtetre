class_name Fox_Rider extends CharacterBody2D

@onready var void_cast: RayCast2D = $VoidCast
@onready var wall_cast: RayCast2D = $WallCast
@onready var vision_collision_shape_2d: CollisionShape2D = $VisionArea2D/VisionCollisionShape2D

enum STATE {
	PATROL, CHASE
}

const GRAVITY: float = 4000.0
const MAX_FALLING_SPEED: float = 1900.0
const SPEED: float = 600.0
const ACCELERATION: float = 1100.0

var direction: float = 1.0
var current_state: STATE = STATE.PATROL

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, MAX_FALLING_SPEED, GRAVITY * delta)
	
	else:	
		if current_state == STATE.PATROL:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
			
			if wall_cast.is_colliding() or !void_cast.is_colliding():
				reverse_direction()
			
	
	move_and_slide()
		

func reverse_direction()-> void:
	direction *= -1
	scale.x *= -1


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print("joueur vu")
