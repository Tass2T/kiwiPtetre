extends State

@onready var idle_state: Idle_State = $"../Idle"
@onready var jump_state: Node = $"../Jump"

func Physics_Process(delta: float) -> State:
	
	if player.direction != 0:
		player.velocity.x = move_toward(player.velocity.x, player.MAX_SPEED * player.direction, player.ACCELERATION * delta)
	else: 
		player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)
		
	if player.velocity.x == 0:
		return idle_state
	
	return null

func Input(input: InputEvent) -> State:
	if (input.is_action_pressed("jump")):
		return jump_state
	return null
