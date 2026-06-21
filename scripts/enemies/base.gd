class_name BaseEnemy extends CharacterBody2D

const GRAVITY: float = 3000
enum STATES {CALM, AGGRO}

const ACCELERATION: float = 7800.0
const MAX_SPEED: float = 1400.0    


var current_state = STATES.CALM
var current_direction: float = -1.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var y_delta = position.y - body.position.y
		if y_delta > 90:
			print("destroy enemy")
		else:
			body.decrease_life()
