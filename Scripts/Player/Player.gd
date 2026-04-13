class_name Player extends CharacterBody2D

@onready var ray_right: RayCast2D = $Ray_Right
@onready var ray_left: RayCast2D = $Ray_Left
@onready var states: State_Manager = $States

const GRAVITY = 1240.0
const JUMP_SPEED = 640.0
const ACCELERATION = 2000.0
const MAX_SPEED = 400.0      
const FRICTION = 4000.0
const BOUNCE_FORCE_Y = 600
const BOUNCE_FORCE_X = 400

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
