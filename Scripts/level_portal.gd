class_name LevelPortal extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	
	Game.go_next_level()
