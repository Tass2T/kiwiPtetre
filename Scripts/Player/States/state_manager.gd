class_name State_Manager extends Node

var states: Array[State] = []

var prev_state: State
var current_state: State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func Initialize(player: Player) -> void:
	for child in get_children():
		if child is State:
			states.push_back(child)
	
	if states.size() > 0:
		set_state(states[0])
		
		current_state.player = player
		process_mode =Node.PROCESS_MODE_INHERIT
		
func _process(delta: float) -> void:
	set_state(current_state.Process(delta))
	
func _physics_process(delta: float) -> void:
	set_state(current_state.Physics_Process(delta))
	
func _unhandled_input(event: InputEvent) -> void:
	set_state(current_state.Input(event))

func set_state(new_state: State):
	if !new_state:
		return
		
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
