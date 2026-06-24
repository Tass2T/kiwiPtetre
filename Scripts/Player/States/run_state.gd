extends State

@onready var idle_state: Idle_State = $"../Idle"
@onready var jump_state: Node = $"../Jump"
@onready var fall_state: Node = $"../Fall"

func Physics_Process(delta: float) -> State:
	
	if not player.is_on_floor():
		return fall_state
	
	if player.direction != 0:
		player.velocity.x = lerp(player.velocity.x, player.direction * player.MAX_SPEED, player.ACCELERATION)
	else: 
		player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION)
		
	if player.velocity.x == 0:
		return idle_state
	
	return null

func Input(input: InputEvent) -> State:
	if (input.is_action_pressed("jump")):
		return jump_state
	return null
