extends CharacterBody2D
@onready var player = $"../player"
@onready var thing = $"../cave"

var min_health = 5 + round((thing.level/5)*5)
var max_health = 10 + round((thing.level/5)*10)
var health
var min_dmg = 1 + round((thing.level/5)*1)
var max_dmg = 3 + round((thing.level/5)*3)
var dmg
var reward_gold
var current_health
var speed
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = randi_range(min_health, max_health)
	current_health = health
	dmg = randi_range(min_dmg, max_dmg)
	reward_gold = round((round(dmg + health))/2)
	screen_size = get_viewport_rect().size
	speed = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if current_health == 0 or current_health < 0:
		death()
	
	velocity = position.direction_to(player.position) * speed
	move_and_slide()
	
func death():
	pass
