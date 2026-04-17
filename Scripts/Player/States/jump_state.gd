extends State

@onready var fall_state: Node = $"../Fall"
@onready var bounce_state: Bounce_State = $"../Bounce"

func Enter() -> void:
	player.velocity.y -= player.JUMP_SPEED

func Physics_Process(delta: float) -> State:
	
	if player.velocity.y > 0:
		return fall_state
	
	player.velocity.x = move_toward(player.velocity.x, player.MAX_SPEED * player.direction, player.ACCELERATION * delta)
	player.velocity.y += player.GRAVITY * delta
	
	return null
	
func Input(input: InputEvent) -> State:
	if input.is_action_pressed("jump") and player.wall_direction != 0:
		return bounce_state
		
	if input.is_action_released("jump") and player.velocity.y < 0:
		player.velocity.y = player.velocity.y / 4
	return null
	
