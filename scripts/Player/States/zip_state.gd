class_name Zip_State extends State

@onready var jump_state: Jump_State = $"../Jump"
@onready var fall_state: Fall_State = $"../Fall"

func Enter() -> void:
	player.velocity = Vector2.ZERO
	
func Physics_Process(delta: float) -> State:
	
	if player.zipline_to_follow.progress_ratio == 1.0:
		return fall_state
	
	player.zipline_to_follow.progress += move_toward(0, player.ZIPLINE_SPEED, player.ZIPLINE_ACCELERATION * delta)
	
	player.position = Vector2(player.zipline_to_follow.position.x, player.zipline_to_follow.position.y + 30)
	
	return null
	
func Input_Process(input: InputEvent) -> State:
	if input.is_action_pressed("jump"):
		return jump_state
	return
