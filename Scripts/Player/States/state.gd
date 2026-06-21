class_name State extends Node

static var player: Player

func Enter() -> void:
	pass
	
func Process(_delta: float) -> State:
	return null
	
func Physics_Process(_delta: float) -> State:
	return null
	
func Input(_input: InputEvent) -> State:
	return null
	
func Exit() -> void:
	pass
