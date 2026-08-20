class_name CheckPoint extends Area2D

@export var passed: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("player")
