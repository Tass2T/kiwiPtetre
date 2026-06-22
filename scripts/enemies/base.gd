class_name BaseEnemy extends CharacterBody2D

const GRAVITY: float = 3000
enum STATES {PATROL, CHASE}

const ACCELERATION: float = 2000.0
const MAX_SPEED: float = 400.0    

@onready var wall_detector: RayCast2D = $WallDetector
@onready var edge_detector: RayCast2D = $EdgeDetector

var current_state = STATES.PATROL
var current_direction: float = 1.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	if wall_detector.is_colliding() or !edge_detector.is_colliding():
		_turn_back()
		
	match current_state:
		STATES.PATROL:
			_patrol_behavior(delta)
		STATES.CHASE:
			_chase_behavior()
	
	
	
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
	
func _chase_behavior() -> void:
	pass

func _turn_back()-> void:
	current_direction *= -1
	wall_detector.target_position.x = abs(wall_detector.target_position.x) * current_direction
	edge_detector.target_position.x = abs(edge_detector.target_position.x) * current_direction
	
	
