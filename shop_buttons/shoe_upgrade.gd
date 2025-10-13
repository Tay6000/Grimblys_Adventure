extends Button

var bought
var price
var description
var bought_description
var upgrades = []
var upgrade = []

func _ready() -> void:
	bought = false
	price = 20
	description = "These sneakers'll make ya faster!\nHere, try em on!\nPrice: " + str(price) + "\nSpeed +100"
	bought_description = "Wow! Yer really movin now!"
	upgrade = ["stat", 4, 100]
	upgrades = [upgrade]
	
	for i in get_children():
		i.visible = false

func _process(delta: float) -> void:
	if bought:
		for i in get_children():
			if !(i.name == "Line2D"):
				if !i.bought:
					i.visible = true
			else:
				i.visible = true
	else:
		for i in get_children():
			i.visible = false
