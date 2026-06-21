class_name BaseEnemy extends CharacterBody2D

const GRAVITY: int = 3000

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		print("not on floor")
