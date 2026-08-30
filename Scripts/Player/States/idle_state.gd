class_name Idle_State extends State

@onready var run_state: Run_State = $"../Run"
@onready var fall_state: Fall_State = $"../Fall"
@onready var jump_state : Jump_State = $"../Jump"
@onready var crouch_state: Crouch_State = $"../Crouch"

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter() -> void:
	animated_sprite_2d.play("idle")

func Physics_Process(_delta: float) -> State:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION)
	
	if !player.is_on_floor():
		return fall_state
	
	if player.direction != 0.0:
		return run_state
		
	return null

func Input_Process(input: InputEvent) -> State:
	if (input.is_action_pressed("jump")):
		return jump_state
	elif input.is_action_pressed("down"):
		return crouch_state
		
	return null
