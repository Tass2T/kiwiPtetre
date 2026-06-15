class_name Game extends Node

var current_level = 1

func _ready() -> void:
	go_to_level(1)

func go_to_level(level_index: int) -> void:
	current_level = level_index
	var path = "res://scenes/levels/level_%02d.tscn" % level_index
	get_tree().change_scene_to_file(path)
