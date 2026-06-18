class_name Player extends CharacterBody2D

@onready var ray_right: RayCast2D = $Ray_Right
@onready var ray_left: RayCast2D = $Ray_Left
@onready var states: State_Manager = $States

const GRAVITY : float = 1240.0
const CLIMB_GRAVITY: float = 100.0
const JUMP_SPEED: float = 1200.0
const ACCELERATION: float = 5000.0
const MAX_SPEED: float = 800.0      
const FRICTION: float = 8000.0
const BOUNCE_FORCE_Y: float  = 600.0
const BOUNCE_FORCE_X: float = 400.0

var direction: float = 0
var wall_direction: float = 0.0

func _ready() -> void:
	states.Initialize(self)

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
