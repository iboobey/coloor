extends CharacterBody2D


@export var walk_speed = 100.0
@export var jump_power = -300.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_power

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)

	move_and_slide()

const BULLET_SCENE=preload("res://scenes/bullet.tscn")
@export var shoot_cooldown: float = 0.5
var can_shoot: bool = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down") and can_shoot:
		shoot()

func shoot() -> void:
	can_shoot = false
	var bullet = BULLET_SCENE.instantiate()
	var dir = -1 if $Sprite2D.flip_h else 1
	bullet.direction = dir
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
