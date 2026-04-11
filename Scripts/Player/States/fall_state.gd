extends State

@onready var Idle_State: Idle_State = $"../Idle"

func Physics_Process(delta: float) -> State:
	
	if player.is_on_floor():
		return Idle_State
		
	if player.direction != 0:
		player.velocity.x = move_toward(player.velocity.x, player.MAX_SPEED * player.direction, player.ACCELERATION * delta)
	else: 
		player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)
	
	player.velocity.y += player.GRAVITY * delta
	
	return null
