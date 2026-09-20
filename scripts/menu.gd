extends Node2D

@onready var blobby: Sprite2D = $UI/Blobby  

var red = Global.player_red
var green = Global.player_green
var blue = Global.player_blue
var player_module : Color = Color(red,green,blue)


func _process(_delta: float) -> void:
	red = Global.player_red
	green = Global.player_green
	blue = Global.player_blue
	player_module = Color.from_rgba8(red,green,blue)
	blobby.modulate = player_module


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		get_tree().change_scene_to_file("res://game.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
