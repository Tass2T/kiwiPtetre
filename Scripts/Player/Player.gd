class_name Player extends CharacterBody2D

@onready var ray_right: RayCast2D = $Ray_Right
@onready var ray_left: RayCast2D = $Ray_Left
@onready var state_manager: State_Manager = $States

const GRAVITY : float = 4000.0
const JUMP_SPEED: float = 1800.0
const ACCELERATION: float = 0.25
const MAX_SPEED: float = 1000.0      
const FRICTION: float = 0.2
const BOUNCE_FORCE_Y: float  = 1400.0
const BOUNCE_FORCE_X: float = 1100.0

var direction: float = 0
var wall_direction: float = 0.0

func _ready() -> void:
	state_manager.Initialize(self)

func _physics_process(_delta: float) -> void:
	
	move_and_slide()
	
	direction = Input.get_axis("left", "right")
	
	wall_direction = check_wall_collision()


func check_wall_collision() -> float:
	if ray_left.is_colliding():
		return -1.0
	elif ray_right.is_colliding():
		return 1.0
		
	return 0
