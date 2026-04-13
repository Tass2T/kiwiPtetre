class_name Crouch_State extends State

func Physics_Process(delta: float) -> State:
	
	player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)

	return null
