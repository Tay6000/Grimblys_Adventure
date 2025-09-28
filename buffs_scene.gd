extends Node2D

#buffs numbers: ["defense", "health", "attack", "speed", "cursed"]
#cursed stats numbers: ["defense", "health", "speed"]

func do_buffs_all():
	do_buffs($buff_1)
	do_buffs($buff_2)
	do_buffs($buff_3)

func do_buffs(button):
	var buff = randi_range(0, 4)
	
	if buff == 0:
		button.Icon
	
