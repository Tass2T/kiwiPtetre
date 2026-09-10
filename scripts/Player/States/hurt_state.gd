class_name Hurt_State extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var idle_state: Idle_State = $"../Idle"
@onready var fall_state: Fall_State = $"../Fall"

@onready var recovery_timer: Timer = $RecoveryTimer

const RECOVERY_TIME: float = 0.6

func Enter() -> void:
	recovery_timer.start(RECOVERY_TIME)
	player.velocity = Vector2.ZERO
	animated_sprite_2d.play("hurt")
	player.velocity.x -= 800 * player.sprite_direction
	player.velocity.y -= 1100

func Physics_Process(delta: float) -> State:
	if player.is_on_floor():
		recovery_timer.stop()
		return idle_state
		
	player.velocity.y = move_toward(player.velocity.y, player.MAX_FALLING_SPEED, player.GRAVITY * delta)
		
	return 


func _on_recovery_timer_timeout() -> void:
	player.trigger_state("fall")
