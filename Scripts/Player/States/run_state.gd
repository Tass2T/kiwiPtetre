extends State

@onready var Idle_State: Idle_State = $"../Idle"
@onready var Jump_State: Node = $"../Jump"

func Physics_Process(delta: float) -> State:
	
	if player.direction != 0:
		player.velocity.x = move_toward(player.velocity.x, player.MAX_SPEED * player.direction, player.ACCELERATION * delta)
	else: 
		player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)
		
	if player.velocity.x == 0:
		return Idle_State
	
	return null

func Input(input: InputEvent) -> State:
	if (input.is_action_pressed("jump")):
		return Jump_State
	return null
