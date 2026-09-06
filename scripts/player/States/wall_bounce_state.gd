class_name Wall_Bounce_State extends State

@onready var fall_state: Fall_State = $"../Fall"
@onready var idle_state: Idle_State = $"../Idle"
@onready var wall_bounce_timer: Timer = $WallBounceTimer

const BOUNCE_FORCE_Y: float  = 1800.0
const BOUNCE_FORCE_X: float = 700.0

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter() -> void:
	Initialize_Bounce()
	animated_sprite_2d.play("jump")

func Physics_Process(delta: float) -> State:
	
	player.velocity.y += player.GRAVITY * delta
	
	if !wall_bounce_timer.is_stopped():
		return
	
	if player.direction != 0:
		player.velocity.x = lerp(player.velocity.x, player.direction * player.speed, player.ACCELERATION)
	else:
		player.velocity.y += player.GRAVITY * delta
	
	if player.velocity.y > 0:
		return fall_state
		
	if player.is_on_floor():
		return idle_state
	
	return null
	

func Input_Process(input: InputEvent) -> State:
	
	if input.is_action_pressed("jump") and player.wall_direction != 0:
		Initialize_Bounce()
	
	return null
	
func Initialize_Bounce() -> void:
	wall_bounce_timer.start()
	player.velocity.x += BOUNCE_FORCE_X * -1 * player.wall_direction
	player.velocity.y = -BOUNCE_FORCE_Y
