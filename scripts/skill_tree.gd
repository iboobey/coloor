extends Node2D

@export var skill_tree_button_group : ButtonGroup

var ability_levels : Array = [1,1,1] # [jump,strenght,dash]
var jump : int = ability_levels[0]        #top
var strenght : int = ability_levels[1]     #right
var dash : int = ability_levels[2]         #left

var able_to_jump : bool = false
var able_to_strength : bool = false
var able_to_dash : bool = false



func _ready() -> void:
	for i in skill_tree_button_group.get_buttons():
		i.disabled = true
	
	
	skill_tree_button_group.pressed.connect(button_pressed)


func refresh_toggle(_button : Button):
	var pressed_button = skill_tree_button_group.get_pressed_button()
	for i in skill_tree_button_group.get_buttons():
		i.set_pressed_no_signal(false)
	pressed_button.set_pressed_no_signal(true)


func button_pressed(button : Button):
	refresh_toggle(button)
	
	match button.name:
		"Row5Button1": ability_levels = [5,1,1]
		"Row4Button1": ability_levels = [4,1,2]
		"Row4Button2": ability_levels = [4,2,1]
		"Row3Button1": ability_levels = [3,1,3]
		"Row3Button2": ability_levels = [3,2,2]
		"Row3Button3": ability_levels = [3,3,1]
		"Row2Button1": ability_levels = [2,1,4]
		"Row2Button2": ability_levels = [2,2,3]
		"Row2Button3": ability_levels = [2,3,2]
		"Row2Button4": ability_levels = [2,4,1]
		"Row1Button1": ability_levels = [1,1,5]
		"Row1Button2": ability_levels = [1,2,4]
		"Row1Button3": ability_levels = [1,3,3]
		"Row1Button4": ability_levels = [1,4,2]
		"Row1Button5": ability_levels = [1,5,1]


func _process(_delta: float) -> void:
	
	button_able_disable()
	
	$Jump.text = "Jump Level: " + str(ability_levels[0])
	$Strength.text = "Strengt Level: " + str(ability_levels[1])
	$Dash.text = "Dash Level: " + str(ability_levels[2])


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


func _on_jump_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		able_to_jump = true
	if toggled_on == false:
		able_to_jump = false


func _on_dash_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		able_to_dash = true
	if toggled_on == false:
		able_to_dash = false


func _on_strength_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		able_to_strength = true
	if toggled_on == false:
		able_to_strength = false
