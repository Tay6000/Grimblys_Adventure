extends Button

var bought
var price
var description
var bought_description

func _ready() -> void:
	bought = false
	price = 1
	description = "This hat'll keep ye safe.\nIt's got some power to it.\nPrice: " + str(price)
	bought_description = "Burn em up for me, will ye?"
	
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
