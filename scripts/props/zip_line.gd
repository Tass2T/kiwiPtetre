class_name Zip_Line extends Path2D

@onready var line_2d: Line2D = $Line2D 
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D


func _ready() -> void:
	
	var points_count: int = curve.point_count

	if points_count > 0:
		for i in points_count:
			line_2d.add_point(curve.get_point_position(i), i)
			
		collision_shape_2d.shape.a = curve.get_point_position(0)
		collision_shape_2d.shape.b = curve.get_point_position(points_count - 1)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		print("joueur entré")
