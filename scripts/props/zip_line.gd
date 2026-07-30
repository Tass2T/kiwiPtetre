class_name Zip_Line extends Path2D

@onready var line_2d: Line2D = $Line2D 
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var path_follow_2d: PathFollow2D = $PathFollow2D

var player: Player

func _ready() -> void:
	
	player = get_tree().root.find_child("Player", true, false)
	
	var points_count: int = curve.point_count

	if points_count > 0:
		for i in points_count:
			line_2d.add_point(curve.get_point_position(i), i)
			
		collision_shape_2d.shape.a = curve.get_point_position(0)
		collision_shape_2d.shape.b = curve.get_point_position(points_count - 1)


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "ZiplineHitbox" and player.state_manager.current_state.name != "Zip":
		var local_pos: Vector2 = to_local(player.global_position)
		
		var offset: float = curve.get_closest_offset(local_pos)
		
		path_follow_2d.progress = offset
		player.set_zipline_path(path_follow_2d)
		player.trigger_state("zip")
		
