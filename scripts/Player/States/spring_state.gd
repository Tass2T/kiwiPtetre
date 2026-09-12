class_name SpringState extends State

@onready var wall_bounce_state: Wall_Bounce_State = $"../WallBounce"
@onready var fall_state: Fall_State = $"../Fall"

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter() -> void:
	animated_sprite_2d.play("spring")
	player.velocity.y -= player.JUMP_SPEED * 2
	
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
		
	return null
