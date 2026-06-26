class_name Jump_State extends State

@onready var fall_state: Node = $"../Fall"
@onready var wall_bounce_state: Wall_Bounce_State = $"../WallBounce"

func Enter() -> void:
	player.velocity.y -= player.JUMP_SPEED

func Physics_Process(delta: float) -> State:
	if player.velocity.y > 0:
		return fall_state
	
	if player.direction != 0:
		player.velocity.x = lerp(player.velocity.x, player.direction * player.speed, player.ACCELERATION)
	else: 
		player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION)
		
	player.velocity.y += player.GRAVITY * delta
	
	return null
	
func Input_Process(input: InputEvent) -> State:
	if input.is_action_pressed("jump") and player.wall_direction != 0:
		return wall_bounce_state
		
	if input.is_action_released("jump") and player.velocity.y < 0:
		player.velocity.y = player.velocity.y / 4
	return null
	
