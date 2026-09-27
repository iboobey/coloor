extends Control

@onready var scroll_container: ScrollContainer = $MarginContainer/ScrollContainer
@onready var accesories: VBoxContainer = $MarginContainer/ScrollContainer/HBoxContainer/Accesories
@onready var equip_unequip: VBoxContainer = $"MarginContainer/ScrollContainer/HBoxContainer/Equip-Unequip"
@onready var acc_names: VBoxContainer = $MarginContainer/ScrollContainer/HBoxContainer/AccNames

var do_hide : bool = false

func _ready() -> void:
	scroll_container.custom_minimum_size = Vector2(20,20)


func _process(_delta: float) -> void:
	if do_hide:
		hide_all()
	if not do_hide:
		show_all()


func hide_all():
	for accesory in accesories.get_children():
		accesory.modulate.a = 0.0
	for acc_name in acc_names.get_children():
		acc_name.modulate.a = 0.0
	for button in equip_unequip.get_children():
		button.modulate.a = 0.0
		button.mouse_filter = Control.MOUSE_FILTER_IGNORE


func show_all():
	for accesory in accesories.get_children():
		accesory.modulate.a = 255.0
	for acc_name in acc_names.get_children():
		acc_name.modulate.a = 255.0
	for button in equip_unequip.get_children():
		button.modulate.a = 255.0
		button.mouse_filter = Control.MOUSE_FILTER_STOP
