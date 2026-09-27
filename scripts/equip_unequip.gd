extends VBoxContainer


func _on_sombrero_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Global.sombrero = true
	elif toggled_on == false:
		Global.sombrero = false
