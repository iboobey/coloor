extends Area2D

@export var speed: float = 10
var direction: float = 1.0
func _physics_process(delta: float) -> void:
	# Move the bullet horizontally based on direction fired
	position.x += direction*speed*delta
# Delete the bullet when it leaves the screen or it hits something
func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
	queue_free()
