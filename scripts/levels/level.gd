class_name Level extends Node2D

var checkpoints: Array[CheckPoint] = []

var player_spawn_position: Vector2

func _ready() -> void:
	for i in get_children():
		if i.name == "Checkpoints":
			for j in i.get_children():
				if j is CheckPoint:
					checkpoints.push_front(j)
			
