extends CharacterBody2D
class_name Monster
@onready var player = $"../player"
@onready var thing = $".."
@onready var spawn1 = $"../spawner1"
@onready var sprite = $monster1_sprite

var min_health
var max_health
var health
var min_dmg
var max_dmg
var dmg
var reward_gold
var current_health
var speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	min_health = 5 + round((thing.level/5)*5)
	max_health = 10 + round((thing.level/5)*10)
	min_dmg = 1 + round((thing.level/5)*1)
	max_dmg = 3 + round((thing.level/5)*3)
	health = randi_range(min_health, max_health)
	current_health = health
	dmg = randi_range(min_dmg, max_dmg)
	reward_gold = round((round(dmg + health))/5)
	speed = 200
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if current_health == 0 or current_health < 0:
		death()
	if player.alive == false:
		death()
	
	$monster_health.text = str(current_health)
	
	velocity = position.direction_to(player.position) * speed
	move_and_slide()
	
func death():
	queue_free()
	get_parent().current_enemies -= 1
	player.gold += reward_gold
	
func take_damage(damage):
	current_health = current_health - damage

func _on_monster_1_collision_body_entered(body: Node2D) -> void:
	player.damage_player(dmg)
	
func _on_attack_body_entered(body: Node2D) -> void:
	take_damage(player.attack)
