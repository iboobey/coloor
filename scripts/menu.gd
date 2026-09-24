extends Node2D

@onready var blobby: Sprite2D = %Blobby

var red = Global.player_red
var green = Global.player_green
var blue = Global.player_blue
var player_module : Color = Color(red,green,blue)

@onready var skill_tree: Control = $MenuTab/SkillTree
@onready var blobby_accesories: Control = $MenuTab/BlobbyAccesories


func _process(_delta: float) -> void:
	red = Global.player_red
	green = Global.player_green
	blue = Global.player_blue
	player_module = Color.from_rgba8(red,green,blue)
	blobby.modulate = player_module
	
	
	
	
	


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
