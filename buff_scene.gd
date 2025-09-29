extends Node2D

@onready var player = $"../player"
@onready var attack = $"../attack"

var buffs_active
var buff1
var buff2
var buff3
var buff1_multiplier = 0.00
var buff2_multiplier = 0.00
var buff3_multiplier = 0.00

#buffs numbers: ["defense", "health", "attack", "speed", "cursed"]
#cursed stats numbers: ["defense", "health", "speed"]

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
		$buff1.text = "defense"
		$buff1/buff1_lbl.text = "defense x" + str(buff1_multiplier)
	elif buff1 == 1:
		$buff1.text = "health"
		$buff1/buff1_lbl.text = "health x" + str(buff1_multiplier)
	elif buff1 == 2:
		$buff1.text = "attack"
		$buff1/buff1_lbl.text = "attack x" + str(buff1_multiplier)
	elif buff1 == 3:
		$buff1.text = "speed"
		$buff1/buff1_lbl.text = "speed x" + str(buff1_multiplier)
	elif buff1 == 4:
		$buff1.text = "cursed"
		$buff1/buff1_lbl.text = "cursed x" + str(buff1_multiplier)
	
func do_buffs_buff2():
	buff2 = randi_range(0, 4)
	buff2_multiplier = randf_range(0.1, 0.5)
	buff2_multiplier = snapped(buff2_multiplier, 0.01)

	if buff2 == 0:
		$buff2.text = "defense"
		$buff2/buff2_lbl.text = "defense x" + str(buff2_multiplier)
	elif buff2 == 1:
		$buff2.text = "health"
		$buff2/buff2_lbl.text = "health x" + str(buff2_multiplier)
	elif buff2 == 2:
		$buff2.text = "attack"
		$buff2/buff2_lbl.text = "attack x" + str(buff2_multiplier)
	elif buff2 == 3:
		$buff2.text = "speed"
		$buff2/buff2_lbl.text = "speed x" + str(buff2_multiplier)
	elif buff2 == 4:
		$buff2.text = "cursed"
		$buff2/buff2_lbl.text = "cursed (test) x" + str(buff2_multiplier)
	
func do_buffs_buff3():
	buff3 = randi_range(0, 4)
	buff3_multiplier = randf_range(0.1, 0.5)
	buff3_multiplier = snapped(buff3_multiplier, 0.01)

	if buff3 == 0:
		$buff3.text = "defense"
		$buff3/buff3_lbl.text = "defense x" + str(buff3_multiplier)
	elif buff3 == 1:
		$buff3.text = "health"
		$buff3/buff3_lbl.text = "health x" + str(buff3_multiplier)
	elif buff3 == 2:
		$buff3.text = "attack"
		$buff3/buff3_lbl.text = "attack x" + str(buff3_multiplier)
	elif buff3 == 3:
		$buff3.text = "speed"
		$buff3/buff3_lbl.text = "speed x" + str(buff3_multiplier)
	elif buff3 == 4:
		$buff3.text = "cursed"
		$buff3/buff3_lbl.text = "cursed (test) x" + str(buff3_multiplier)
	
func activate_buttons():
	$buff1.disabled = false
	$buff2.disabled = false
	$buff3.disabled = false
	
func deactivate_buttons():
	$buff1.disabled = true
	$buff2.disabled = true
	$buff3.disabled = true
	
func _on_buff_1_pressed() -> void:
	print("buff1 pressed")
	if buff3 == 0:
		player.defense_buffs.append(buff3_multiplier)
	elif buff3 == 1:
		player.health_buffs.append(buff3_multiplier)
	elif buff3 == 2:
		attack.attack_buffs.append(buff3_multiplier)
	elif buff3 == 3:
		player.speed_buffs.append(buff3_multiplier)
	elif buff3 == 4:
		print("cursed")
