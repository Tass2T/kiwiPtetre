class_name Climb_State extends State

@onready var idle_state: Idle_State = $"../Idle"
@onready var bounce_state: Bounce_State = $"../Bounce"
@onready var fall_state: Fall_State = $"../Fall"

func Enter() -> void:
	player.velocity.y = player.velocity.y / 2

func Physics_Process(delta: float) -> State:
	player.velocity.y += (player.GRAVITY / 4) * delta
	
	if player.is_on_floor(): 
		return idle_state
	
	if player.direction == 0 or player.wall_direction == 0: return fall_state
	
	return null
	
func Input_Process(input: InputEvent) -> State:
	if input.is_action_pressed("jump"):
		return bounce_state
	return null
