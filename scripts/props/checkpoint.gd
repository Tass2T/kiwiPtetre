class_name CheckPoint extends Area2D

@export var checkpoint_id: String = ""
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	if GameManager.last_checkpoint_id == checkpoint_id:
		set_passed()
	else:
		color_rect.color = Color(1.0,1.0,1.0)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		color_rect.color = Color(0.4,0.2, 0.4)
		GameManager.set_checkpoint_id(checkpoint_id)
		GameManager.set_player_spawn_position(position)

func set_passed() -> void:
	color_rect.color = Color(0.4,0.2, 0.4)
