class_name Player extends CharacterBody2D

@onready var ray_right: RayCast2D = $Ray_Right
@onready var ray_left: RayCast2D = $Ray_Left
@onready var state_manager: State_Manager = $States
@onready var bounce_state: BounceState = $States/Bounce
@onready var fall_state: Fall_State = $States/Fall
@onready var zip_state: Zip_State = $States/Zip
@onready var lose_state: Lose_State = $States/Lose
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY : float = 4000.0
const JUMP_SPEED: float = 1800.0
const ACCELERATION: float = 0.25
const DEFAULT_SPEED: float = 1000.0
const ZIPLINE_SPEED: float = 2000
const ZIPLINE_ACCELERATION: int = 1700
const FRICTION: float = 0.2

const BOUNCE_FORCE_Y: float  = 2000.0
const BOUNCE_FORCE_X: float = 500.0

var direction: float = 1.0
var sprite_direction: float = 1.0
var wall_direction: float = 0.0
var speed = DEFAULT_SPEED
var is_sprinting: bool = false
var zipline_to_follow: PathFollow2D

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
		"bounce":
			state_manager.set_state(bounce_state)
		"fall":
			state_manager.set_state(fall_state)
		"zip":
			state_manager.set_state(zip_state)
		"lost": 
			state_manager.set_state(lose_state)
	
	return
	
func set_zipline_path(new_zipline_to_follow: PathFollow2D) -> void:
	zipline_to_follow = new_zipline_to_follow
	
func lose() -> void:
	GameManager.handle_game_over()
