class_name Player extends CharacterBody2D

@onready var ray_right: RayCast2D = $Ray_Right
@onready var ray_left: RayCast2D = $Ray_Left
@onready var state_manager: State_Manager = $States
@onready var spring_state: SpringState = $States/Spring
@onready var fall_state: Fall_State = $States/Fall
@onready var zip_state: Zip_State = $States/Zip
@onready var hurt_state: Hurt_State = $States/Hurt
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var invincibility_timer: Timer = $Invincibility_Timer

const GRAVITY : float = 4000.0
const JUMP_SPEED: float = 1800.0
const ACCELERATION: float = 0.25
const DEFAULT_SPEED: float = 1000.0
const ZIPLINE_SPEED: float = 2000
const ZIPLINE_ACCELERATION: int = 1700
const FRICTION: float = 0.2
const INVISIBILITY_TIME: float = 3
const MAX_FALLING_SPEED: float = 1900.0

var direction: float = 1.0
var sprite_direction: float = 1.0
var wall_direction: float = 0.0
var speed = DEFAULT_SPEED
var is_sprinting: bool = false
var zipline_to_follow: PathFollow2D
var is_invicible: bool = false
var tween: Tween

func _ready() -> void:
	state_manager.Initialize(self)
	
	if GameManager.player_spawn_position != Vector2.ZERO:
		position = GameManager.player_spawn_position
	
	visible = true

func _physics_process(_delta: float) -> void:
	
	move_and_slide()
	
	direction = Input.get_axis("left", "right")
	
	if direction and direction != sprite_direction:
		sprite_direction = direction
		animated_sprite_2d.flip_h = direction < 0
			
	wall_direction = check_wall_collision()

func check_wall_collision() -> float:
	if ray_left.is_colliding():
		return -1.0
	elif ray_right.is_colliding():
		return 1.0
		
	return 0
	
func trigger_state(new_state: String) -> void:
	match new_state:
		"spring":
			state_manager.set_state(spring_state)
		"fall":
			state_manager.set_state(fall_state)
		"zip":
			state_manager.set_state(zip_state)
		"lost":
			if !is_invicible:
				is_invicible = true
				invincibility_timer.start(INVISIBILITY_TIME)
				start_blinking()
				state_manager.set_state(hurt_state)
	
	return
	
	
func set_zipline_path(new_zipline_to_follow: PathFollow2D) -> void:
	zipline_to_follow = new_zipline_to_follow
	
func send_back_to_last_checkpoint() -> void:
	GameManager.handle_game_over()

func _on_invincibility_timer_timeout() -> void:
	is_invicible = false
	stop_blinking()
	
func start_blinking() -> void:
	tween = create_tween().set_loops()
	tween.tween_property(animated_sprite_2d, "modulate:a", 0.0, 0.10)
	tween.tween_property(animated_sprite_2d, "modulate:a", 1.0, 0.10)
	tween.tween_interval(0.2)

func stop_blinking() -> void:
	if tween:
		tween.kill()
	animated_sprite_2d.modulate.a = 1.0
