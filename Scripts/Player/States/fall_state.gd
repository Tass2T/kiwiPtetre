class_name Fall_State extends State

@onready var idle_state: Idle_State = $"../Idle"
@onready var bounce_state: State = $"../Bounce"
@onready var climb_state: Climb_State = $"../Climb"

func Enter() -> void:
	pass

func Physics_Process(delta: float) -> State:
	
	if player.is_on_floor():
		return idle_state
		
	if player.direction != 0:
		player.velocity.x = move_toward(player.velocity.x, player.MAX_SPEED * player.direction, player.ACCELERATION * delta)
	else: 
		player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)
	
	if player.wall_direction != 0 and player.direction == player.wall_direction:
		return climb_state
	
	player.velocity.y += player.GRAVITY * delta

	
	return null
	
func Input(input: InputEvent) -> State:
	if input.is_action_pressed("jump") and player.wall_direction != 0:
		return bounce_state
	return null
