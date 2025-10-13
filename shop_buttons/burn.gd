extends Button

var bought
var price
var description
var bought_description
var upgrades = []
var upgrade = []

func _ready() -> void:
	bought = false
	price = 100
	description = "I can enchant your attacks with fire.\nFor a price, of course.\nPrice: " + str(price) + "\nAdds fire aspect to your weapon"
	bought_description = "Hows that enchantment working for ye?"
	upgrade = ["power", "fire"]
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
