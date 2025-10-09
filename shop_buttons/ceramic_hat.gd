extends Button

var bought
var price

func _ready() -> void:
	bought = false
	price = 1
	
	for i in get_children():
		i.visible = false

func _process(delta: float) -> void:
	if bought:
		for i in get_children():
			if !i.bought:
				i.visible = true
	
	for i in get_parent().get_children():
		if i.bought == true && i != self:
			disabled = true
