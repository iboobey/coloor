extends Control


func _ready() -> void:
	highlight_segment(1,2,Color8(0,0,0),%LinksHorizontal1)


func highlight_segment(start_point_index : int, end_point_index : int, highlight_color : Color,links : Line2D):
	
	var total_length : float = 0.0
	var segment_lengths : Array[float] = []
	
	for i in range(links.points.size() -1):
		var length = links.points[i].distance_to(links.points[i+1])
		segment_lengths.append(length)
		total_length += length
	
	if total_length == 0.0:
		return
	
	var distance_to_start : float = 0.0
	for i in range(start_point_index):
		distance_to_start += segment_lengths[i]
	
	var distance_to_end : float = 0.0
	for i in range(start_point_index, end_point_index):
		distance_to_end += segment_lengths[i]
	
	var start_uv = distance_to_start / total_length
	var end_uv = distance_to_end / total_length
	
	var shader = links.material as ShaderMaterial
	if shader:
		shader.set_shader_parameter("segment_start",start_uv)
		shader.set_shader_parameter("segment_end",end_uv)
		shader.set_shader_parameter("segment_color",highlight_color)
