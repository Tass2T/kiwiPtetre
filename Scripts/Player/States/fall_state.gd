class_name Fall_State extends State

@onready var idle_state: Idle_State = $"../Idle"
@onready var wall_bounce_state: Wall_Bounce_State = $"../WallBounce"
@onready var climb_state: Climb_State = $"../Climb"
@onready var jump_state: Jump_State = $"../Jump"

const JUMP_BUFFER_TIME: float = 0.12
const MAX_FALLING_SPEED: float = 1900.0
var jump_buffer_timer: float = 0.0
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter() -> void:
	jump_buffer_timer = 0
	animated_sprite_2d.play("fall")

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
	
	player.velocity.y = move_toward(player.velocity.y, MAX_FALLING_SPEED, player.GRAVITY * delta)

	
	return null
	
func Input_Process(input: InputEvent) -> State:
	if input.is_action_pressed("jump"):
		if player.wall_direction != 0:
			return wall_bounce_state
		
		jump_buffer_timer = JUMP_BUFFER_TIME
		
	return null
