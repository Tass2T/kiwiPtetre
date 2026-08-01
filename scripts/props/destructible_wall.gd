class_name DestructibleWall extends StaticBody2D

const DESTRUCT_TIMER: float = 1.0

@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and timer.is_stopped():
		timer.start(DESTRUCT_TIMER)


func _on_timer_timeout() -> void:
	visible = false
	collision_shape_2d.disabled = true
