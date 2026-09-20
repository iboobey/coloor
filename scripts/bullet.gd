extends Area2D

@export var speed: float = 50
var direction: float = 1.0
func _physics_process(delta: float) -> void:
	# Move the bullet horizontally based on direction fired
	position.x += direction*speed*delta
# Delete the bullet when it leaves the screen or it hits something


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Level1Glass":
		area.get_parent().queue_free()
		queue_free()
