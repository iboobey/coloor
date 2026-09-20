extends Control

@export var skill_tree_button_group : ButtonGroup

@onready var links_horizontal_1: Line2D = %LinksHorizontal1
@onready var links_horizontal_2 : Line2D = %LinksHorizontal2
@onready var links_horizontal_3 : Line2D = %LinksHorizontal3
@onready var links_horizontal_4 : Line2D = %LinksHorizontal4
@onready var links_vertical_1: Line2D = %LinksVertical1
@onready var links_vertical_2 : Line2D = %LinksVertical2
@onready var links_vertical_3 : Line2D = %LinksVertical3
@onready var links_vertical_4 : Line2D = %LinksVertical4
@onready var links_horizontal : Array = [links_horizontal_1, links_horizontal_2, links_horizontal_3, links_horizontal_4]



var ability_levels : Array = [1,1,1] # [jump,strenght,dash] [green,blue,red]
var jump : int = ability_levels[0]        #top
var strenght : int = ability_levels[1]     #right
var dash : int = ability_levels[2]         #left

var able_to_jump : bool = false
var able_to_strength : bool = false
var able_to_dash : bool = false

#color variables
var module_array : Array = []
var color_step : float = 255.0 / 4.0
#link variables
var link_correction_offset : Vector2 = Vector2(-8,181.875)

func _ready() -> void:
	for i in skill_tree_button_group.get_buttons():
		i.disabled = true
	
	skill_tree_button_group.pressed.connect(button_pressed)
	
	skill_linking()


func refresh_toggle(_button : Button):
	var pressed_button = skill_tree_button_group.get_pressed_button()
	for i in skill_tree_button_group.get_buttons():
		i.set_pressed_no_signal(false)
	pressed_button.set_pressed_no_signal(true)


func button_pressed(button : Button):
	refresh_toggle(button)
	
	match button.name:
		"Row5Button1":
			ability_levels = [5,1,1]
		"Row4Button1":
			ability_levels = [4,1,2]
		"Row4Button2":
			ability_levels = [4,2,1]
		"Row3Button1":
			ability_levels = [3,1,3]
		"Row3Button2":
			ability_levels = [3,2,2]
		"Row3Button3":
			ability_levels = [3,3,1]
		"Row2Button1":
			ability_levels = [2,1,4]
		"Row2Button2":
			ability_levels = [2,2,3]
		"Row2Button3":
			ability_levels = [2,3,2]
		"Row2Button4":
			ability_levels = [2,4,1]
		"Row1Button1":
			ability_levels = [1,1,5]
		"Row1Button2":
			ability_levels = [1,2,4]
		"Row1Button3":
			ability_levels = [1,3,3]
		"Row1Button4":
			ability_levels = [1,4,2]
		"Row1Button5":
			ability_levels = [1,5,1]
	
	module_array = ability_levels.map(func(n): return (n-1) * color_step)
	Global.player_red = module_array[2]
	Global.player_green = module_array[0]
	Global.player_blue = module_array[1]
	


func _process(_delta: float) -> void:
	
	button_able_disable()
	
	%JumpLabel.text = "Jump Level: " + str(ability_levels[0])
	%DashLabel.text = "Strength Level: " + str(ability_levels[1])
	%StrengthLabel.text = "Dash Level: " + str(ability_levels[2])


func button_able_disable():
	if able_to_jump:
		%Row5Button1.disabled = false
	if able_to_dash:
		%Row1Button1.disabled = false
	if able_to_strength:
		%Row1Button5.disabled = false
	if able_to_dash and able_to_jump:
		%Row5Button1.disabled = false
		%Row4Button1.disabled = false
		%Row3Button1.disabled = false
		%Row2Button1.disabled = false
		%Row1Button1.disabled = false
	if able_to_jump and able_to_strength:
		%Row5Button1.disabled = false
		%Row4Button2.disabled = false
		%Row3Button3.disabled = false
		%Row2Button4.disabled = false
		%Row1Button5.disabled = false
	if able_to_strength and able_to_dash:
		%Row1Button1.disabled = false
		%Row1Button2.disabled = false
		%Row1Button3.disabled = false
		%Row1Button4.disabled = false
		%Row1Button5.disabled = false
	if able_to_dash and able_to_jump and able_to_strength:
		for i in skill_tree_button_group.get_buttons():
			i.disabled = false
	
	
	if not(able_to_jump):
		%Row5Button1.disabled = true
	if not(able_to_dash):
		%Row1Button1.disabled = true
	if not(able_to_strength):
		%Row1Button5.disabled = true
	if not(able_to_dash and able_to_jump):
		%Row4Button1.disabled = true
		%Row3Button1.disabled = true
		%Row2Button1.disabled = true
	if not(able_to_jump and able_to_strength):
		%Row4Button2.disabled = true
		%Row3Button3.disabled = true
		%Row2Button4.disabled = true
	if not(able_to_strength and able_to_dash):
		%Row1Button2.disabled = true
		%Row1Button3.disabled = true
		%Row1Button4.disabled = true
	if not(able_to_dash and able_to_jump and able_to_strength):
		%Row3Button2.disabled = true
		%Row2Button2.disabled = true
		%Row2Button3.disabled = true


func _on_jump_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		able_to_jump = true
	if toggled_on == false:
		able_to_jump = false


func _on_dash_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		able_to_dash = true
	if toggled_on == false:
		able_to_dash = false


func _on_strength_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		able_to_strength = true
	if toggled_on == false:
		able_to_strength = false


#Skill Links

func skill_linking():

	await get_tree().process_frame

	get_tree().call_group("SkillLinks","clear_points")
	
	var h_start_array : Array = [%Row1Button1.global_position / 8,
	 %Row2Button1.global_position / 8,
	 %Row3Button1.global_position / 8,
	 %Row4Button1.global_position / 8]
	
	var h_step = Vector2(+16,0)
	var h_points : int = 5
	
	for i in range(links_horizontal.size()):
		for point in range(h_points):
			links_horizontal[i].add_point(h_start_array[i] + link_correction_offset + point * h_step)
		h_points -= 1
	
