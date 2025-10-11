extends CanvasLayer

@onready var player = $"../player"
@onready var attack = $"../player/attack"
@onready var button_buff1 = $buff1
@onready var button_buff2 = $buff2
@onready var button_buff3 = $buff3
@onready var label_buff1 = $buff1/buff1_lbl
@onready var label_buff2 = $buff2/buff2_lbl
@onready var label_buff3 = $buff3/buff3_lbl
@onready var atk = load("res://Sprites/Attack_buff1.png")
@onready var def = load("res://Sprites/defense_buff1.png")
@onready var health = load("res://Sprites/health_buff1.png")
@onready var speed = load("res://Sprites/speed_buff1.png")

var buffs_active
var buff
var buff_multiplier = 0.00

#buffs numbers: ["defense", "health", "attack", "speed", "cursed"]
#cursed stats numbers: ["defense", "health", "speed"]

func _ready() -> void:
	activate_buttons()
	do_buffs_all()

func do_buffs_all():
	do_buffs(button_buff1, label_buff1)
	do_buffs(button_buff2, label_buff2)
	do_buffs(button_buff3, label_buff3)
	activate_buttons()
	buffs_active = true

func do_buffs(button : Node, label : Node):
	buff = randi_range(0, 4)
	buff_multiplier = snapped(randf_range(0.10, 0.50), 0.01)
	
	if buff == 0:
		button.icon = def
		label.text = "defense x" + str(buff_multiplier)
		button.buff = buff
		button.multiplier = buff_multiplier
	elif buff == 1:
		button.icon = health
		label.text = "health x" + str(buff_multiplier)
		button.buff = buff
		button.multiplier = buff_multiplier
	elif buff == 2:
		button.icon = atk
		label.text = "attack x" + str(buff_multiplier)
		button.buff = buff
		button.multiplier = buff_multiplier
	elif buff == 3:
		button.icon = speed
		label.text = "speed x" + str(buff_multiplier)
		button.buff = buff
		button.multiplier = buff_multiplier
	elif buff == 4:
		button.icon = null
		label.text = "cursed x" + str(buff_multiplier)
		button.buff = buff
		button.multiplier = buff_multiplier
	
func activate_buttons():
	button_buff1.disabled = false
	button_buff2.disabled = false
	button_buff3.disabled = false
	button_buff1.visible = true
	button_buff2.visible = true
	button_buff3.visible = true
	
func deactivate_buttons():
	button_buff1.disabled = true
	button_buff2.disabled = true
	button_buff3.disabled = true
	button_buff1.visible = false
	button_buff2.visible = false
	button_buff3.visible = false
	
func _on_button_pressed(button_path : NodePath):
	var button = get_node(button_path)
	print(button.name)
	if button.buff == 0:
		player.defense_buffs.append(button.multiplier)
	elif button.buff == 1:
		player.health_buffs.append(button.multiplier)
	elif button.buff == 2:
		player.attack_buffs.append(button.multiplier)
	elif button.buff == 3:
		player.speed_buffs.append(button.multiplier)
	elif button.buff == 4:
		print("cursed")
	deactivate_buttons()
