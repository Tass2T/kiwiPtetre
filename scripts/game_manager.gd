class_name Game_Manager extends Node

var current_level: int = 1
var player_spawn_position: Vector2
var current_level_node: Node = null

func _ready() -> void:
	load_level()

func load_level() -> void:
	if current_level_node:
		current_level_node.queue_free()
		current_level_node = null
		
	var path: String = "res://scenes/levels/level_%d.tscn" % current_level
	var level_scene: PackedScene = load(path)
	
	if level_scene == null:
		push_error("Impossible de charger le niveau : %s" % path)
		return
		
	current_level_node = level_scene.instantiate()
	
	add_child(current_level_node)
	
func set_player_spawn_position(new_position: Vector2):
	player_spawn_position = new_position

func go_next_level() -> void:
	current_level += 1
	load_level()

func handle_game_over() -> void:
	load_level.call_deferred()
