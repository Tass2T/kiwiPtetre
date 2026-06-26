class_name Run_State extends State

@onready var idle_state: Idle_State = $"../Idle"
@onready var jump_state: Node = $"../Jump"
@onready var fall_state: Node = $"../Fall"
@onready var crouch_state: Crouch_State = $"../Crouch"
@onready var coyote_timer: Timer = $CoyoteTimer

const COYOTE_FRAMES: int = 7
var coyote: bool = false
var last_floor: bool = false
	
func Enter() -> void:
	coyote_timer.wait_time = COYOTE_FRAMES / 60.0

func Physics_Process(_delta: float) -> State:
	
	var on_floor = player.is_on_floor()
	
	if !on_floor:
		if last_floor:
			coyote = true
			coyote_timer.start()
		elif !coyote:
			return fall_state
	
	last_floor = on_floor
	
	if player.direction != 0:
		player.velocity.x = lerp(player.velocity.x, player.direction * player.MAX_SPEED, player.ACCELERATION)
	else: 
		return idle_state
	 
	return null

func Input_Process(input: InputEvent) -> State:
	if (input.is_action_pressed("jump") and (player.is_on_floor() or coyote)):
		coyote = false
		return jump_state
	elif input.is_action_pressed("down"):
		return crouch_state
	
	return null


func _on_coyote_timer_timeout() -> void:
	coyote = false
