extends VBoxContainer


func _ready() -> void:
	if Global.sombrero == true:
		%Sombrero.button_pressed = true


func _on_sombrero_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Global.sombrero = true
	elif toggled_on == false:
		Global.sombrero = false
