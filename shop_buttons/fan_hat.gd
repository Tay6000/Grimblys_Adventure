extends Button

var bought
var price
var description
var bought_description

func _ready() -> void:
	bought = false
	price = 1
	description = "EH? This one ain't even stylish...\nWell, as long as yer payin.\nPrice: " + str(price)
	bought_description = "So yer actually gettin use out of it..."
	
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
