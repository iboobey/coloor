extends CharacterBody2D

@export var dash_cooldown: float= 0.2
@export var dash_speed = 800.0
@export var walk_speed = 100.0
@export var jump_power = -300.0
var can_dash : bool = true

const BULLET_SCENE=preload("res://scenes/bullet.tscn")

@export var shoot_cooldown: float = 0.5
var can_shoot: bool = true

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		$Sprite2D.flip_h = false 
	elif velocity.x < 0:
		$Sprite2D.flip_h = true 
	$Sprite2D.modulate = Color.from_rgba8(Global.player_red, Global.player_green, Global.player_blue)
	
	move(delta)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down") and can_shoot:
		shoot()
	if event.is_action_pressed("menu"):
		get_tree().change_scene_to_file("res://scenes/MenuScenes/menu.tscn")


func move(delta):
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_power


	var directiondash:= Input.get_axis("dedash","dash")
	if directiondash and can_dash:
		velocity.x = directiondash * dash_speed
		await get_tree().physics_frame
		await get_tree().physics_frame
		await get_tree().physics_frame
		await get_tree().physics_frame
		can_dash = false
		await get_tree().create_timer(dash_cooldown).timeout
		can_dash = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, dash_speed)

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)


func shoot() -> void:
	can_shoot = false
	var bullet = BULLET_SCENE.instantiate()
	var dir = -1 if $Sprite2D.flip_h else 1
	bullet.direction = dir
	bullet.global_position = global_position
	get_tree().current_scene.add_child(bullet)
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
