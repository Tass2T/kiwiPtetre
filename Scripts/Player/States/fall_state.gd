class_name Fall_State extends State

@onready var idle_state: Idle_State = $"../Idle"
@onready var bounce_state: Bounce_State = $"../Bounce"
@onready var climb_state: Climb_State = $"../Climb"
@onready var jump_state: Jump_State = $"../Jump"

const JUMP_BUFFER_TIME: float = 0.12
var jump_buffer_timer: float = 0.0

func Enter() -> void:
	jump_buffer_timer = 0

func Physics_Process(delta: float) -> State:
	
	if jump_buffer_timer > 0.0:
		jump_buffer_timer -= delta
		
	if player.is_on_floor():
		if jump_buffer_timer > 0.0:
			jump_buffer_timer = 0.0
			return jump_state
		return idle_state
		
	if player.direction != 0:
		player.velocity.x = lerp(player.velocity.x, player.direction * player.speed, player.ACCELERATION)
	else: 
		player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION)
	
	if player.wall_direction != 0 and player.direction == player.wall_direction:
		return climb_state
	
	player.velocity.y += player.GRAVITY * delta

	
	return null
	
func Input_Process(input: InputEvent) -> State:
	if input.is_action_pressed("jump"):
		if player.wall_direction != 0:
			return bounce_state
		
		jump_buffer_timer = JUMP_BUFFER_TIME
		
	return null
