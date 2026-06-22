class_name BaseEnemy extends CharacterBody2D

const GRAVITY: float = 3000
enum STATES {PATROL, CHASE}

const ACCELERATION: float = 2000.0
const MAX_SPEED: float = 400.0    

const CHASE_ACCELERATION: float = 3000
const CHASE_MAX_SPEED: float = 600

@onready var wall_detector: RayCast2D = $WallDetector
@onready var edge_detector: RayCast2D = $EdgeDetector
@onready var vision_area: Area2D = $VisionArea

var current_state = STATES.PATROL
var current_direction: float = 1.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	if wall_detector.is_colliding() or !edge_detector.is_colliding():
		if current_state == STATES.CHASE:
			current_state = STATES.PATROL
		_turn_back()
		
	match current_state:
		STATES.PATROL:
			_patrol_behavior(delta)
		STATES.CHASE:
			_chase_behavior(delta)
	
	
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var y_delta = position.y - body.position.y
		if y_delta > 90:
			print("destroy enemy")
		else:
			body.decrease_life()


func _patrol_behavior(delta: float) -> void:
	velocity.x = move_toward(velocity.x, MAX_SPEED * current_direction, ACCELERATION * delta)
	
func _chase_behavior(delta: float) -> void:
	velocity.x = move_toward(velocity.x, CHASE_MAX_SPEED * current_direction, CHASE_ACCELERATION * delta)

func _turn_back()-> void:
	current_direction *= -1
	wall_detector.target_position.x = abs(wall_detector.target_position.x) * current_direction
	edge_detector.target_position.x = abs(edge_detector.target_position.x) * current_direction
	vision_area.scale.x = current_direction
	


func _on_vision_area_body_entered(body: Node2D) -> void:
	current_state = STATES.CHASE
