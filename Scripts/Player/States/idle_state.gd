class_name Idle_State extends State

@onready var Run_State: Node = $"../Run"
@onready var Fall_State: Node = $"../Fall"
@onready var Jump_State : Node = $"../Jump"

func Physics_Process(_delta: float) -> State:
	if not player.is_on_floor():
		return Fall_State
	
	if player.direction != 0.0:
		return Run_State
		
	return null

func Input(input: InputEvent) -> State:
	if (input.is_action_pressed("jump")):
		return Jump_State
	return null
