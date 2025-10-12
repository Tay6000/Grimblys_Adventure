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
	description = "If yer gonna wear impracticle hats,\nat least this one'll protect you.\nPrice: " + str(price) + "\nSummons a sharp hat that deals 1/4 of your attack"
	bought_description = "If any monsters try to get ya, now ye'll be protected"
	upgrade = ["power", "razor"]
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
