class_name Moving_Platform extends AnimatableBody2D

@export var waypoints: Array[Vector2] = []
@export var speed: float = 100.0    
@export var loop: bool = true                
@export var wait_time: float = 0.0             
@export var start_delay: float = 0.0    

var _current_index: int = 0
var _direction: int = 1
var _waiting: bool = false
var _started: bool = false

func _ready() -> void:
	if waypoints.is_empty():
		return
	await get_tree().create_timer(start_delay).timeout
	_started = true

func _physics_process(delta: float) -> void:
	if not _started or _waiting or waypoints.is_empty():
		return

	var target = to_global(waypoints[_current_index])
	var direction_vec = (target - global_position)
	var distance = direction_vec.length()
	var move_step = speed * delta

	if move_step >= distance:
		global_position = target
		_on_waypoint_reached()
	else:
		move_and_collide(direction_vec.normalized() * move_step)

func _on_waypoint_reached() -> void:
	if wait_time > 0.0:
		_waiting = true
		await get_tree().create_timer(wait_time).timeout
		_waiting = false

	if loop:
		_current_index = (_current_index + 1) % waypoints.size()
	else:
		var next = _current_index + _direction
		if next >= waypoints.size() or next < 0:
			_direction *= -1
			next = _current_index + _direction
		_current_index = next
