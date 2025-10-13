extends Button

var bought
var price
var description
var bought_description
var upgrades = []
var upgrade = []

func _ready() -> void:
	bought = false
	price = 75
	description = "This tonic'll help yer beard\ngrow in longer!\nPrice: " + str(price) + "\nAttack +3"
	bought_description = "Lookin' more like a dwarf already!"
	upgrade = ["stat", 3, 3]
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
