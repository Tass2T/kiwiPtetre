extends Node

var current_level: int = 1

func _ready() -> void:
	load_level()

func load_level() -> void:
	var path: String = "res://Scenes/levels/level_%d.tscn" % current_level
	get_tree().change_scene_to_file(path)

func go_next_level() -> void:
	current_level += 1
	load_level()
