class_name Owl_Rider extends Area2D

enum State { PATROL, DIVE, RECOVER }

@export var patrol_amplitude := 20.0   # amplitude du va-et-vient en pixels
@export var patrol_frequency := 1.0    # vitesse d'oscillation (cycles/sec)
@export var detection_range := 250.0

var current_state := State.PATROL
var patrol_time: float = 0.0
var patrol_origin: Vector2 = Vector2.ZERO
var player: Player

func _ready() -> void:
	patrol_origin = global_position
	pass

func _process(delta: float) -> void:
	match current_state:
		State.PATROL:
			_patrol(delta)
	pass
	
func _can_see_player() -> bool:
	if player == null:
		return false
	var dist = global_position.distance_to(player.global_position)
	if dist > detection_range:
		return false
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	return result.is_empty() or result.collider == player
			
func _patrol(delta: float) -> void:
	patrol_time = fmod(patrol_time + delta, 1.0 / patrol_frequency)
	var offset_y = sin(patrol_time * TAU * patrol_frequency) * patrol_amplitude
	global_position = patrol_origin + Vector2(0, offset_y)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(1)
