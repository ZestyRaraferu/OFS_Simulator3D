extends ImmediateGeometry

onready var target_position = Vector3(0, -1.875, 0)
onready var start_position_node = $"../Stroker/Top"
onready var distance_label = $"../UI/DistanceLabel"

func _process(_delta):
	clear()
	begin(Mesh.PRIMITIVE_LINES, null)
	add_vertex(start_position_node.global_transform.origin)
	add_vertex(target_position)
	end()

	var distance = start_position_node.global_transform.origin.distance_to(target_position)
	var percentage = (distance / 2.0) * 100
	distance_label.text = "%.0f%%" % percentage
	
	var fraction = max(min((distance - 1.8) / (2.0 - 1.8), 1.0), 0.0)
	
	if percentage > 100:
		material_override.albedo_color = Color.fuchsia
		distance_label.modulate = Color.purple
	else:
		var base_color = Color(3, 3, 3)
		var target_color = Color.hotpink
		var color = base_color.linear_interpolate(target_color, fraction)
		distance_label.modulate = color
		material_override.albedo_color = color
	
