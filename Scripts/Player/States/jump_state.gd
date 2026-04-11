extends State

@onready var Fall_State: Node = $"../Fall"

func Enter() -> void:
	player.velocity.y -= player.JUMP_SPEED

func Physics_Process(delta: float) -> State:
	
	if player.velocity.y > 0:
		return Fall_State
	
	player.velocity.y += player.GRAVITY * delta
	
	return null
	
func Input(input: InputEvent) -> State:
	if input.is_action_released("jump") and player.velocity.y < 0:
		player.velocity.y = player.velocity.y / 4
	return null
	
