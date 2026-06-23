class_name FlyingEnemy extends CharacterBody2D

enum State {PATROL, AGGRO, DIVE, RETURN}

var current_state :FlyingEnemy.State = State.PATROL
var patrol_speed   : float = 80.0
var spawn_pos    : Vector2
var bob_time     : float = 0.0
var bob_frequency  : float = 2.0
var bob_amplitude  : float = 30.0
var patrol_range : float = 140.0

func _ready() -> void:
	spawn_pos = global_position

func _physics_process(delta: float) -> void:
	match current_state:
		State.PATROL: _patrol(delta)
		State.AGGRO: _aggro(delta)
		State.DIVE: _dive(delta)
		State.RETURN: _return(delta)
	
	move_and_slide()
	
func _patrol(delta: float) -> void:
	bob_time += delta
	var bob_offset = Vector2(0, sin(bob_time * bob_frequency) * bob_amplitude)
	velocity = Vector2(0, cos(bob_time * bob_frequency) * bob_amplitude * bob_frequency)
	
	global_position.x = spawn_pos.x + sin(bob_time * patrol_speed / patrol_range) * patrol_range
	
	velocity.x = 0.0 
	velocity.y = cos(bob_time * bob_frequency) * bob_amplitude * bob_frequency

func _aggro(delta: float) -> void:
	pass

func _dive(delta: float) -> void:
	pass

func _return(delta: float) -> void:
	pass
	
