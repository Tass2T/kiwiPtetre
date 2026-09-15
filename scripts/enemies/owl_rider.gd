class_name Owl_Rider extends Area2D

enum State { PATROL, DIVE, TURN, RECOVER }

@export var patrol_amplitude := 15.0
@export var patrol_frequency := 1.5
@export var detection_range := 400.0
@export var dive_duration := 1.5        # temps pour parcourir l'arc, en secondes
@export var dive_depth_offset := 180.0   # profondeur du piqué sous/vers le joueur
@export var dive_side_extent := 150.0   # distance parcourue après le joueur
@export var turn_duration := 0.3        # petite pause avant de repartir
@export var recover_speed := 150.0

var current_state := State.PATROL
var patrol_time: float = 0.0
var patrol_origin: Vector2 = Vector2.ZERO
var player: Player
var velocity: Vector2 = Vector2.ZERO

# Bézier pour le dive
var dive_start: Vector2
var dive_control: Vector2
var dive_end: Vector2
var dive_time: float = 0.0
var turn_time: float = 0.0

var dive_control1: Vector2
var dive_control2: Vector2

func _ready() -> void:
	patrol_origin = global_position
	call_deferred("_find_player")

func _process(delta: float) -> void:
	match current_state:
		State.PATROL:
			if not is_instance_valid(player):
				_find_player()
			if _can_see_player():
				_start_dive()
		State.DIVE:
			_dive(delta)
		State.TURN:
			_turn(delta)
			
func _find_player() -> void:
	player = get_tree().get_first_node_in_group("player")

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

func _start_dive() -> void:
	dive_start = global_position
	var target = player.global_position

	var side = sign(target.x - dive_start.x)
	if side == 0:
		side = 1

	# deux points de contrôle proches du joueur en profondeur,
	# décalés horizontalement pour créer un "plancher" à la trajectoire
	dive_control1 = Vector2(dive_start.x + (target.x - dive_start.x) * 0.5, target.y + dive_depth_offset)
	dive_control2 = Vector2(target.x + side * dive_side_extent * 0.3, target.y + dive_depth_offset)

	dive_end = Vector2(target.x + side * dive_side_extent, dive_start.y)

	dive_time = 0.0
	current_state = State.DIVE


func _dive(delta: float) -> void:
	dive_time += delta
	var t = clamp(dive_time / dive_duration, 0.0, 1.0)
	var prev_position = global_position
	global_position = _cubic_bezier(dive_start, dive_control1, dive_control2, dive_end, t)
	velocity = (global_position - prev_position) / delta

	if t >= 1.0:
		turn_time = 0.0
		current_state = State.TURN

func _turn(delta: float) -> void:
	velocity = Vector2.ZERO
	turn_time += delta
	# ici tu peux flip le sprite, jouer une anim "turn", etc.
	# ex: sprite.flip_h = not sprite.flip_h
	if turn_time >= turn_duration:
		patrol_origin = global_position
		current_state = State.PATROL

func _cubic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float) -> Vector2:
	var a = p0.lerp(p1, t)
	var b = p1.lerp(p2, t)
	var c = p2.lerp(p3, t)
	var d = a.lerp(b, t)
	var e = b.lerp(c, t)
	return d.lerp(e, t)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage()
