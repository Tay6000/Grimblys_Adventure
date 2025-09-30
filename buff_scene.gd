extends Node2D

@onready var player = $"../player"
@onready var attack = $"../attack"
@onready var button_buff1 = $buff1
@onready var button_buff2 = $buff2
@onready var button_buff3 = $buff3
@onready var label_buff1 = $buff1/buff1_lbl
@onready var label_buff2 = $buff2/buff2_lbl
@onready var label_buff3 = $buff3/buff3_lbl

var buffs_active
var buff1
var buff2
var buff3
var buff1_multiplier = 0.00
var buff2_multiplier = 0.00
var buff3_multiplier = 0.00

#buffs numbers: ["defense", "health", "attack", "speed", "cursed"]
#cursed stats numbers: ["defense", "health", "speed"]

func _ready() -> void:
	button_buff1.connect("pressed", Callable(self, "_on_buff_1_pressed").bind(button_buff1))

func do_buffs_all():
	do_buffs_buff1()
	do_buffs_buff2()
	do_buffs_buff3()
	activate_buttons()
	buffs_active = true

func do_buffs_buff1():
	buff1 = randi_range(0, 4)
	buff1_multiplier = randf_range(0.10, 0.50)
	buff1_multiplier = snapped(buff1_multiplier, 0.01)
	
	if buff1 == 0:
		button_buff1.text = "defense"
		label_buff1.text = "defense x" + str(buff1_multiplier)
	elif buff1 == 1:
		button_buff1.text = "health"
		label_buff1.text = "health x" + str(buff1_multiplier)
	elif buff1 == 2:
		button_buff1.text = "attack"
		label_buff1.text = "attack x" + str(buff1_multiplier)
	elif buff1 == 3:
		button_buff1.text = "speed"
		label_buff1.text = "speed x" + str(buff1_multiplier)
	elif buff1 == 4:
		button_buff1.text = "cursed"
		label_buff1.text = "cursed x" + str(buff1_multiplier)
	
func do_buffs_buff2():
	buff2 = randi_range(0, 4)
	buff2_multiplier = randf_range(0.1, 0.5)
	buff2_multiplier = snapped(buff2_multiplier, 0.01)

	if buff2 == 0:
		button_buff2.text = "defense"
		label_buff2.text = "defense x" + str(buff2_multiplier)
	elif buff2 == 1:
		button_buff2.text = "health"
		label_buff2.text = "health x" + str(buff2_multiplier)
	elif buff2 == 2:
		button_buff2.text = "attack"
		label_buff2.text = "attack x" + str(buff2_multiplier)
	elif buff2 == 3:
		button_buff2.text = "speed"
		label_buff2.text = "speed x" + str(buff2_multiplier)
	elif buff2 == 4:
		button_buff2.text = "cursed"
		label_buff2.text = "cursed (test) x" + str(buff2_multiplier)
	
func do_buffs_buff3():
	buff3 = randi_range(0, 4)
	buff3_multiplier = randf_range(0.1, 0.5)
	buff3_multiplier = snapped(buff3_multiplier, 0.01)

	if buff3 == 0:
		button_buff3.text = "defense"
		label_buff3.text = "defense x" + str(buff3_multiplier)
	elif buff3 == 1:
		button_buff3.text = "health"
		label_buff3.text = "health x" + str(buff3_multiplier)
	elif buff3 == 2:
		button_buff3.text = "attack"
		label_buff3.text = "attack x" + str(buff3_multiplier)
	elif buff3 == 3:
		button_buff3.text = "speed"
		label_buff3.text = "speed x" + str(buff3_multiplier)
	elif buff3 == 4:
		button_buff3.text = "cursed"
		label_buff3.text = "cursed (test) x" + str(buff3_multiplier)
	
func activate_buttons():
	button_buff1.disabled = false
	button_buff2.disabled = false
	button_buff3.disabled = false
	button_buff1.visible = true
	button_buff2.visible = true
	button_buff3.visible = true
	
func deactivate_buttons():
	button_buff1.disabled = true
	button_buff2.disabled = true
	button_buff3.disabled = true
	button_buff1.visible = false
	button_buff2.visible = false
	button_buff3.visible = false
	
func _on_buff_1_pressed() -> void:
	print("buff1 pressed")
	if Input.is_action_just_pressed("select") && button_buff1.in_area == true:
		if buff1 == 0:
			player.defense_buffs.append(buff1_multiplier)
		elif buff1 == 1:
			player.health_buffs.append(buff1_multiplier)
		elif buff1 == 2:
			attack.attack_buffs.append(buff1_multiplier)
		elif buff1 == 3:
			player.speed_buffs.append(buff1_multiplier)
		elif buff1 == 4:
			print("cursed")
