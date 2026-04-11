class_name Player extends CharacterBody2D

const GRAVITY = 1240.0
const JUMP_SPEED = 640.0
const ACCELERATION = 2000.0
const MAX_SPEED = 400.0      
const FRICTION = 4000.0

var direction: float = 0

@onready var states: State_Manager = $States

func _ready() -> void:
	states.Initialize(self)

func _physics_process(_delta: float) -> void:
	
	direction = Input.get_axis("left", "right")
	
	move_and_slide()
