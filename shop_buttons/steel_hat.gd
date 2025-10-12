extends Button

var bought
var price
var description
var bought_description
var upgrades = []
var upgrade1 = []
var upgrade2 = []

func _ready() -> void:
	bought = false
	price = 75
	description = "This is the heaviest hat I got.\nIt'll keep ye safe, but ye'll be slower\nPrice: " + str(price) + "\nDefense +4 Speed -50"
	bought_description = "Yer gonna get squished under that thing!"
	upgrade1 = ["stat", 1, 4]
	upgrade2 = ["stat", 4, -50]
	upgrades = [upgrade1, upgrade2]
	
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
