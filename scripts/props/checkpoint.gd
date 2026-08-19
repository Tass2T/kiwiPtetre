class_name CheckPoint extends Area2D

@export var initial_checkpoint: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("player")
