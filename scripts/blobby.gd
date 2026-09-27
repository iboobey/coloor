extends CharacterBody2D

@onready var blobby: AnimatedSprite2D = %Blobby

@export var dash_bar: TextureProgressBar
@export var dash_duration: float = 0.1
@export var dash_cooldown: float = 1
@export var dash_speed: float = 800
@export var walk_speed = 100
@export var jump_power = -300
var can_dash : bool = true
var dash_timer: float = 0
var is_dashing: bool = false
var facing_dir: float = 1


const DASH_MARKER_SCENE = preload("res://scenes/marker.tscn")
var marker_instance: Node2D = null


func _ready() -> void:
	marker_instance = DASH_MARKER_SCENE.instantiate()
	add_child(marker_instance)
	marker_instance.visible = false

func _physics_process(delta: float) -> void:
	if not can_dash:
		dash_timer -= delta
		if dash_bar:
			dash_bar.value = dash_cooldown - dash_timer
	facing_dir = -1 if $Sprite2D.flip_h else 1
	
	var input_axis := Input.get_axis("left","right")
	if input_axis != 0:
		facing_dir = input_axis
	
	if facing_dir >0:
		blobby.flip_h = false
	elif facing_dir <0:
		blobby.flip_h = true
	
	
	if Input.is_action_just_pressed("dash") and can_dash:
		perform_dash(facing_dir)
		
	blobby.modulate = Color.from_rgba8(Global.player_red, Global.player_green, Global.player_blue)
	
	move(delta)
	move_and_slide()
	
	if can_dash:
		marker_instance.visible = true
		var actual_dash_distance = dash_speed * dash_duration
		marker_instance.position = Vector2((facing_dir * actual_dash_distance+10), 0)
	else:
		marker_instance.visible = false

<<<<<<< HEAD
=======
func _process(_delta: float) -> void: 
	if Global.sombrero == true:
		%Sombrero.visible = true
	else: %Sombrero.visible = false


>>>>>>> c13df932b58b6f95fa78e718a5acfcb4eff87ece
func perform_dash(_dir:float) -> void:
	if not can_dash:
		return
		
	can_dash = false
	is_dashing = true
	dash_timer = dash_cooldown
	marker_instance.visible = false
	
	if dash_bar:
		dash_bar.value = 0
	
	velocity.y = 0
	velocity.x = _dir * dash_speed
	
	await get_tree().create_timer(dash_duration).timeout
	is_dashing = false
	
	await get_tree().create_timer(dash_cooldown - dash_duration).timeout
	can_dash=true


func _exit_tree() -> void:
	if is_instance_valid(marker_instance):
		marker_instance.queue_free()



const BULLET_SCENE=preload("res://scenes/bullet.tscn")

@export var shoot_cooldown: float = 0.5
var can_shoot: bool = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down") and can_shoot:
		shoot()
	if event.is_action_pressed("menu"):
		get_tree().change_scene_to_file("res://scenes/MenuScenes/menu.tscn")


func move(delta):
	
	if is_dashing:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_power
	else:
		velocity.x = move_toward(velocity.x, 0, dash_speed)
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)


func shoot() -> void:
	can_shoot = false
	animate("shoot")
	await blobby.frame_changed
	await blobby.frame_changed
	await blobby.frame_changed
	await blobby.frame_changed
	var bullet = BULLET_SCENE.instantiate()
	var dir = -1 if blobby.flip_h else 1
	bullet.direction = dir
	bullet.global_position = global_position + Vector2(7,-2)
	get_tree().current_scene.add_child(bullet)
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()

func animate(animation):
	blobby.play(animation)
