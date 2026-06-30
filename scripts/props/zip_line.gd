class_name Zip_Line extends Path2D

@onready var path_follow_2d: PathFollow2D = $PathFollow2D

@export var speed: float = 200.0

var player: Player
var is_active: bool = false

func _physics_process(delta: float) -> void:
	
	if !is_active or player == null:
		return
		
	if path_follow_2d.progress_ratio >= 1.0:
		return
	
	path_follow_2d.progress += speed * delta

func attach_player(p: Player) -> void:
	player = p
	player.trigger_state("zip")
	path_follow_2d.progress = 0.0
	is_active = true
	
	
func detach_player()-> void:
	is_active = false
	player.trigger_state("fall")
	player = null
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		attach_player(body)
		
		
