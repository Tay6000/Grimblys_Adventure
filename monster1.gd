extends CharacterBody2D
class_name Monster
@onready var player = $"../player"
@onready var thing = $".."
@onready var spawn1 = $"../spawner1"
@onready var sprite = $monster1_sprite
@onready var difficulty_tracker = $"../shop/other/difficulty_tracker"

var min_health
var max_health
var health
var min_dmg
var max_dmg
var dmg
var reward_gold
var current_health
var speed
var level
var difficulty
var taking_damage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	difficulty = difficulty_tracker.difficulty_multiplier
	level = thing.level - 1
	min_health = 5 + round((float(level)/5.0)*5)
	max_health = 10 + round((float(level)/5.0)*10)
	min_dmg = 1 + round((float(level)/5.0)*1)
	max_dmg = 3 + round((float(level)/5.0)*3)
	health = (randi_range(min_health, max_health)) * difficulty
	current_health = health
	dmg = (randi_range(min_dmg, max_dmg)) * difficulty
	reward_gold = round(float(dmg + health)/5.0)
	speed = 100
	taking_damage = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if current_health == 0 or current_health < 0:
		death()
	if player.alive == false:
		death()
	
	$monster_health.text = str(int(current_health))
	
	if !taking_damage:
		velocity = position.direction_to(player.position) * speed
		if velocity.x < 0:
			$monster1_sprite.scale.x = 0.2
		else:
			$monster1_sprite.scale.x = -0.2
	move_and_slide()
	
func death():
	queue_free()
	get_parent().current_enemies -= 1
	player.reward_gold += reward_gold
	
func take_damage(damage, aspect):
	current_health = current_health - damage
	$monster1_sprite.modulate = Color(0, 0, 0, 1)
	taking_damage = true
	$monster1_collision/CollisionShape2D.disabled = true
	await get_tree().create_timer(0.05).timeout
	velocity = -(position.direction_to(player.position) * 300)
	$monster1_sprite.modulate = Color(1, 1, 1, 1)
	await get_tree().create_timer(0.05).timeout
	move_and_slide()
	taking_damage = false
	$monster1_collision/CollisionShape2D.disabled = false

func _on_monster_1_collision_body_entered(body: Node2D) -> void:
	player.damage_player(dmg)
