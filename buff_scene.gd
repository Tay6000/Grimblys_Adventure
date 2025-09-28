extends Node2D

#buffs numbers: ["defense", "health", "attack", "speed", "cursed"]
#cursed stats numbers: ["defense", "health", "speed"]

func do_buffs_all():
	do_buffs_buff1()
	do_buffs_buff2()
	do_buffs_buff3()

func do_buffs_buff1():
	var buff = randi_range(0, 4)

	if buff == 0:
		$buff1.text = "defense"
	elif buff == 1:
		$buff1.text = "health"
	elif buff == 2:
		$buff1.text = "attack"
	elif buff == 3:
		$buff1.text = "speed"
	elif buff == 4:
		$buff1.text = "cursed"
	
func do_buffs_buff2():
	var buff = randi_range(0, 4)

	if buff == 0:
		$buff2.text = "defense"
	elif buff == 1:
		$buff2.text = "health"
	elif buff == 2:
		$buff2.text = "attack"
	elif buff == 3:
		$buff2.text = "speed"
	elif buff == 4:
		$buff2.text = "cursed"
	
func do_buffs_buff3():
	var buff = randi_range(0, 4)

	if buff == 0:
		$buff3.text = "defense"
	elif buff == 1:
		$buff3.text = "health"
	elif buff == 2:
		$buff3.text = "attack"
	elif buff == 3:
		$buff3.text = "speed"
	elif buff == 4:
		$buff3.text = "cursed"
	
