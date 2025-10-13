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
	price = 25
	description = "This tonic'll make ya stronger,\nbut it'll stop working eventually!\nPrice: " + str(price) + "\nAttack +2, " + str(amount_bought) + "/10"
	bought_description = "This won't make ya stronger anymore."
	upgrade = ["stat", 3, 2]
	upgrades = [upgrade]
	
	for i in get_children():
		i.visible = false

func _process(delta: float) -> void:
	if bought && amount_bought < 10:
		bought = false
		amount_bought += 1
		price = 25 * (amount_bought + 1)
	elif amount_bought >= 10:
		bought = true
	
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
	
	description = "This tonic'll make ya stronger,\nbut it'll stop working eventually!\nPrice: " + str(price) + "\nAttack +2, " + str(amount_bought) + "/10"
