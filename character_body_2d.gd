extends CharacterBody2D
var pos:Vector2
var rota:float
var dir : float
var speed= 2000

func _ready():
	pos=global_position
func _physics_process(delta):
	velocity=Vector2(speed,0).rotated(dir)
	move_and_slide()
	
