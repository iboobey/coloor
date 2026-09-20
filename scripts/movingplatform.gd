extends StaticBody2D

var limit_max = 60 # furthest it goes to the sides
var step = 40
var go_left : bool = false
var go_right : bool = true


func _physics_process(delta: float) -> void:
	move_platform(delta)

func move_platform(delta):
	if global_position.x < limit_max and go_right:
		global_position.x += step * delta
	if global_position.x >= limit_max:
		go_right = false
		go_left = true
	if global_position.x > -limit_max and go_left:
		global_position.x -= step * delta
	if global_position.x <= -limit_max:
		go_right = true
		go_left = false
