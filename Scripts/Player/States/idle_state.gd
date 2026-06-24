class_name Idle_State extends State

@onready var run_state: Node = $"../Run"
@onready var fall_state: Node = $"../Fall"
@onready var jump_state : Node = $"../Jump"
@onready var crouch_state: Crouch_State = $"../Crouch"

func Physics_Process(_delta: float) -> State:
	
	player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION)
	
	if not player.is_on_floor():
		return fall_state
	
	if player.direction != 0.0:
		return run_state
		
	return null

func Input(input: InputEvent) -> State:
	if (input.is_action_pressed("jump")):
		return jump_state
	elif input.is_action_pressed("down"):
		return crouch_state
		
	return null
