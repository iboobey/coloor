extends Node2D

@onready var blobby: Sprite2D = %Blobby

var red = Global.player_red
var green = Global.player_green
var blue = Global.player_blue
var player_module : Color = Color(red,green,blue)

var red_frame : int = 0
var green_frame : int = 0
var blue_frame : int = 0

@onready var skill_tree: Control = $MenuTab/SkillTree
@onready var blobby_accesories: Control = $MenuTab/BlobbyAccesories


func _process(_delta: float) -> void:
	red = Global.player_red
	green = Global.player_green
	blue = Global.player_blue
	player_module = Color.from_rgba8(red,green,blue)
	blobby.modulate = player_module
	
	color_wheel()


func hide_instances():
	skill_tree.hide()
	blobby_accesories.hide()


func _on_home_pressed() -> void:
	hide_instances()


func _on_settings_pressed() -> void:
	hide_instances()


func _on_blobby_accesories_pressed() -> void:
	hide_instances()
	blobby_accesories.show()


func _on_skill_tree_pressed() -> void:
	hide_instances()
	skill_tree.show()


func _on_menu_game_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func color_wheel():
	red = Global.player_red
	var red_index : int = 3 * red / 63.75
	red_frame = red_index
	green = Global.player_green
	var green_index : int = 3 * green / 63.75
	green_frame = green_index
	blue = Global.player_blue
	var blue_index : int = 3 * blue / 63.75
	blue_frame = blue_index
	
	if red_frame < %RedWheel.frame:
		%RedWheel.speed_scale = -1.0
		%RedWheel.play("Red")
	elif red_frame > %RedWheel.frame:
		%RedWheel.speed_scale = 1.0
		%RedWheel.play("Red")
	else:
		%RedWheel.pause()
	
	
	if green_frame < %GreenWheel.frame:
		%GreenWheel.speed_scale = -1.0
		%GreenWheel.play("Green")
	elif green_frame > %GreenWheel.frame:
		%GreenWheel.speed_scale = 1.0
		%GreenWheel.play("Green")
	else:
		%GreenWheel.pause()
	
	
	if blue_frame < %BlueWheel.frame:
		%BlueWheel.speed_scale = -1.0
		%BlueWheel.play("Blue")
	elif blue_frame > %BlueWheel.frame:
		%BlueWheel.speed_scale = 1.0
		%BlueWheel.play("Blue")
	else:
		%BlueWheel.pause()
