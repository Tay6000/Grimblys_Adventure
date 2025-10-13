extends Button

var bought
var price
var description
var bought_description
var upgrades = []
var upgrade = []
var amount_bought = 0

func _ready() -> void:
	bought = false
	price = 10
	description = "This tonic'll up yer vitality.\nUnlike the strength one, drink up!\nPrice: " + str(price) + "\nHealth +3, "
	bought_description = "I'm sold out!"
	upgrade = ["stat", 2, 3]
	upgrades = [upgrade]
	
	for i in get_children():
		i.visible = false

func _process(delta: float) -> void:
	if bought:
		bought = false
		amount_bought += 1
		price = 10 * (amount_bought + 2)
	
	if amount_bought > 0:
		for i in get_children():
			if !(i.name == "Line2D"):
				if !i.bought:
					i.visible = true
			else:
				i.visible = true
	else:
		for i in get_children():
			i.visible = false
	
	description = "This tonic'll up yer vitality.\nUnlike the strength one, drink up!\nPrice: " + str(price) + "\nHealth +3, "
