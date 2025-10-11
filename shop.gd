extends CanvasLayer

@onready var root_node = $".."
@onready var player = $"../player"
@onready var fade_to_black = $"../fade"
@onready var shop_text = $shop_text

var tabs = []

#buffs numbers: ["defense", "health", "attack", "speed"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	tabs = [$hats, $equipment, $beards, $other]
	
	for tab in tabs:
		tab.visible = true
		for x in tab.get_children():
			x.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc") && visible == true:
		fade_to_black.fade_out()
		player.update_defense()
		player.update_health()
		player.update_speed()
		player.update_attack()
		player.position.x = 947
		player.position.y = 810
		await get_tree().create_timer(2).timeout
		root_node.enable_things()
		fade_to_black.fade_in()
		visible = false
	
	$player_gold.text = "Gold: " + str(int(player.gold))

func _on_upgrade_pressed(button_path: NodePath):
	var button = get_node(button_path)
	if player.gold >= button.price:
		if !button.bought:
			player.gold -= button.price
			button.bought = true
			shop_text.text = button.bought_description
			for i in button.upgrades:
				if i[0] == "stat":
					add_upgrade(i)
				elif i[0] == "power":
					pass
				elif i[0] == "ability":
					pass
				else:
					print("somethings wrong, no upgrade type")
	else:
		shop_text.text = "ya don't got enough gold!"

func _on_tab_pressed(button_path: NodePath):
	var button = get_node(button_path)
	for i in button.get_children():
		i.visible = true
	
	for tab in tabs:
		if tab != get_node(button_path):
			for x in tab.get_children():
				x.visible = false

func _on_button_hover(button_path: NodePath):
	var button = get_node(button_path)
	if !button.bought:
		shop_text.text = button.description
	else:
		shop_text.text = button.bought_description

func add_upgrade(upgrade : Array):
	if upgrade[1] == 1:
		player.defense_upgrades.append(upgrade[2])
	elif upgrade[1] == 2:
		player.health_upgrades.append(upgrade[2])
	elif upgrade[1] == 3:
		player.attack_upgrades.append(upgrade[2])
	elif upgrade[1] == 4:
		player.speed_upgrades.append(upgrade[2])
