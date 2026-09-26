extends ScrollContainer

func _ready() -> void:
	var bar = get_v_scroll_bar()
	bar.custom_maximum_size = Vector2(6,-1)
