extends Button

var bought
var price
var description
var bought_description
var upgrades = []
var upgrade = []

func _ready() -> void:
	bought = false
	price = 1
	description = "I'll fix yer hat for ye!\nIt'll cost ye though.\nPrice: " + str(price)
	bought_description = "There ye go. Good as new."
	upgrade = ["stat", 1, 1]
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
	
	for i in get_parent().get_children():
		if !(i.name == "Line2D"):
			if i.bought == true && i != self:
				disabled = true
