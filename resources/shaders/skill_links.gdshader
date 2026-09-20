shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(0.2, 0.2, 0.2, 1.0);
uniform vec4 segment_color : source_color = vec4(1.0, 1.0, 0.0, 0.0);

uniform float segment_start : hint_range(0.0, 1.0) = 0;
uniform float segment_end : hint_range(0.0, 1.0) = 0;

void fragment() {
	if (UV.x >= segment_start && UV.x < segment_end) {
		COLOR = segment_color;
} else {COLOR = line_color;}
}