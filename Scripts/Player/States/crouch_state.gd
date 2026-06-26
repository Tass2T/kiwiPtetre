class_name Crouch_State extends State

@onready var idle: Idle_State = $"../Idle"
@onready var collision_shape_2d: CollisionShape2D = $"../../CollisionShape2D"

var collision_shape_original_size: Vector2

func Enter() -> void:
	collision_shape_original_size = collision_shape_2d.shape.size
	collision_shape_2d.shape.size = Vector2(collision_shape_original_size.x, collision_shape_original_size.y / 2)
	collision_shape_2d.position.y = collision_shape_original_size.y / 4
	
func Physics_Process(_delta: float) -> State:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION / 2)
	return null
	
func Input_Process(input: InputEvent) -> State:
	if input.is_action_released("down"):
		return idle
	return null
	
func Exit() -> void:
	collision_shape_2d.shape.size = collision_shape_original_size
	collision_shape_2d.position.y = 0.0
