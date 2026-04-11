class_name Idle_State extends State

@onready var run_state: Node = $"../Run"
@onready var fall_state: Node = $"../Fall"
@onready var jump_state : Node = $"../Jump"

func Physics_Process(delta: float) -> State:
	
	player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)
	
	if not player.is_on_floor():
		return fall_state
	
	if player.direction != 0.0:
		return run_state
		
	return null

func Input(input: InputEvent) -> State:
	if (input.is_action_pressed("jump")):
		return jump_state
		
	return null
