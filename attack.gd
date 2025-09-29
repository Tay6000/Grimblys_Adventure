extends Area2D

@onready var monster1_node = load("res://Monster.tscn")

var attack_upgrades = []
var attack_buffs = []
var attack
var base_attack = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	var attack = base_attack


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("attack"):
		$Sprite2D.visible = true
		$CollisionShape2D.disabled = false
		await get_tree().create_timer(0.2).timeout
		$Sprite2D.visible = false
		$CollisionShape2D.disabled = true


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() is Monster:
		area.get_parent().take_damage(attack)

func update_attack():
	attack = base_attack
	for i in attack_upgrades:
		var upgrade = attack_upgrades[i]
		attack += upgrade
	for i in attack_buffs:
		var buff = attack_buffs[i]
		var attack_add = round(attack * buff)
		attack = attack + buff
