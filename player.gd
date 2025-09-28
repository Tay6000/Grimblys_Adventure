extends CharacterBody2D

var direction = "back"
@export var base_speed = 400
@export var base_health = 10
@export var base_defense = 0
var speed = base_speed
var health = base_health
var defense = base_defense
var speed_upgrades = []
var health_upgrades = []
var defense_upgrades = []
var speed_buffs = []
var health_buffs = []
var defense_buffs = []
var gold
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	update_defense()
	update_health()
	update_speed()

# updated comment that does nothing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
		direction = "back"
	elif Input.is_action_pressed("move_down"):
		velocity.y = 1
		direction = "front"
	else:
		velocity.y = 0
	
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
		direction = "right"
	elif Input.is_action_pressed("move_left"):
		velocity.x = -1
		direction = "left"
	else:
		velocity.x = 0
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if velocity.x > 0:
			$PlayerSprite.play("grimbly_right_walk")
		elif velocity.x < 0:
			$PlayerSprite.play("grimbly_left_walk")
		if velocity.y > 0:
			$PlayerSprite.play("grimbly_front_walk")
		elif velocity.y < 0:
			$PlayerSprite.play("grimbly_back_walk")
	else:
		$PlayerSprite.play("idle_" + direction)
		
	if health == 0 or health < 0:
		pass
		
	move_and_slide()

func update_speed() -> void:
	speed = base_speed
	for i in speed_upgrades:
		var upgrade = speed_upgrades[i]
		speed = speed + upgrade
	for i in speed_buffs:
		var buff = speed_buffs[i]
		var speed_add = speed * buff
		speed = speed + speed_add
		
func update_health() -> void:
	health = base_health
	for i in health_upgrades:
		var upgrade = health_upgrades[i]
		health = health + upgrade
	for i in health_buffs:
		var buff = health_buffs[i]
		var health_add = health * buff
		health = health + health_add
		
func update_defense() -> void:
	defense = base_defense
	for i in defense_upgrades:
		var upgrade = defense_upgrades[i]
		defense = defense + upgrade
	for i in defense_buffs:
		var buff = defense_buffs[i]
		var defense_add = defense * buff
		defense = defense + defense_add
		
func death() -> void:
	speed_buffs = []
	defense_buffs = []
	health_buffs = []
	#put reset items function here
	update_defense()
	update_health()
	update_speed()
	position.x = 947
	position.y = 810
