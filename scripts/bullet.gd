extends Area2D

@export var speed: float = 50
var direction: float = 1.0
func _physics_process(delta: float) -> void:
	position.x += direction*speed*delta
	$Sprite2D.modulate = Color.from_rgba8(Global.player_red, Global.player_green, Global.player_blue)

	
	position.x += direction*speed*delta



func _on_area_entered(area: Area2D) -> void:
	if area.name == "Level1Glass":
		area.get_parent().queue_free()
		queue_free()
