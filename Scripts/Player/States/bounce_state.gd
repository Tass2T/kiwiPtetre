class_name Bounce_State extends State

@onready var fall_state: Node = $"../Fall"

func Enter() -> void:
	Initialize_Bounce()

func Physics_Process(delta: float) -> State:
	player.velocity.y += player.GRAVITY * delta
	
	if player.velocity.y > 0:
		return fall_state
	
	return null
	

func Input(input: InputEvent) -> State:
	
	if input.is_action_pressed("jump") and player.wall_direction != 0:
		Initialize_Bounce()
	
	return null
	
func Initialize_Bounce() -> void:
	player.velocity.x += player.BOUNCE_FORCE_X * -1 * player.wall_direction
	player.velocity.y = -player.BOUNCE_FORCE_Y
