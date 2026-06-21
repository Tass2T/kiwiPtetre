class_name Player extends CharacterBody2D

@onready var ray_right: RayCast2D = $Ray_Right
@onready var ray_left: RayCast2D = $Ray_Left
@onready var state_manager: State_Manager = $States

const GRAVITY : float = 3000.0
const CLIMB_GRAVITY: float = 1200.0
const JUMP_SPEED: float = 1500.0
const ACCELERATION: float = 7800.0
const MAX_SPEED: float = 1400.0      
const FRICTION: float = 9000.0
const BOUNCE_FORCE_Y: float  = 1400.0
const BOUNCE_FORCE_X: float = 800.0

var direction: float = 0
var wall_direction: float = 0.0

var life: int = 3

func _ready() -> void:
	state_manager.Initialize(self)

func _physics_process(_delta: float) -> void:
	
	direction = Input.get_axis("left", "right")
	
	wall_direction = check_wall_collision()
	
	move_and_slide()


func check_wall_collision() -> float:
	if ray_left.is_colliding():
		return -1.0
	elif ray_right.is_colliding():
		return 1.0
		
	return 0
	
func decrease_life() -> void:
	life -= 1
	if life == 0:
		Game.handle_game_over()
