class_name FlyingEnemy extends CharacterBody2D

enum State {PATROL, AGGRO, DIVE, RETURN}

var current_state :FlyingEnemy.State = State.PATROL
var patrol_speed   : float = 80.0
var spawn_pos    : Vector2
var bob_time     : float = 0.0
var bob_frequency  : float = 3.0
var bob_amplitude  : float = 30.0
var patrol_range : float = 140.0
var timer        : float = 0.0
var aggro_windup   : float = 0.6
var target_pos   : Vector2
var dive_dir     : Vector2 
var dive_speed     : float = 400.0
var return_speed   : float = 150.0
var detection_range: float = 800.0
var player: Player

func _ready() -> void:
	spawn_pos = global_position
	player = get_tree().get_first_node_in_group("player")
	print(player)

func _physics_process(delta: float) -> void:
	match current_state:
		State.PATROL: _patrol(delta)
		State.AGGRO: _aggro(delta)
		State.DIVE: _dive(delta)
		State.RETURN: _return(delta)
	
	move_and_slide()
	
func _enter_aggro() -> void:
	current_state = State.AGGRO
	velocity = Vector2.ZERO
	timer = 0.0

func _enter_dive() -> void:
	current_state = State.DIVE
	target_pos = player.global_position          # verrouille la cible
	dive_dir = (target_pos - global_position).normalized()
	
func _enter_return() -> void:
	current_state = State.RETURN
	bob_time = 0.0
	
func _patrol(delta: float) -> void:
	bob_time += delta
	
	velocity.x = cos(bob_time * patrol_speed / patrol_range) * patrol_range
	velocity.y = cos(bob_time * bob_frequency) * bob_amplitude * bob_frequency
	
	if player and global_position.distance_to(player.global_position) < detection_range:
		_enter_aggro()

func _aggro(delta: float) -> void:
	timer += delta
	if timer >= aggro_windup:
		_enter_dive()

func _dive(_delta: float) -> void:
	velocity = dive_dir * dive_speed
	
	# Arrive près de la cible OU touche le sol → on remonte
	var dist = global_position.distance_to(target_pos)
	if dist < 20.0 or is_on_floor():
		_enter_return()

func _return(_delta: float) -> void:
	# Direction vers le spawn, mais légèrement à côté (effet d'arc)
	var to_spawn = (spawn_pos - global_position)
	var dist = to_spawn.length()
	
	if dist < 10.0:
		global_position = spawn_pos
		current_state = State.PATROL
		return
	
	velocity = to_spawn.normalized() * return_speed
	
