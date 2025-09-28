extends CharacterBody2D

@onready var cave = $"../cave"
@onready var fade_to_black = $"../fade"
@onready var portal = $"../portal"
@onready var player_health = $"../player_health"
@onready var buff_scene = $"../buff_scene"
@onready var level_music = $"../level_music"
@onready var lobby_music = $"../lobby_music"
@onready var player_gold = $"../player_gold"
@onready var root_node = $".."
@onready var attack = $"../attack"

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
var current_health
var gold
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	update_defense()
	update_health()
	update_speed()
	current_health = health
	gold = 0
	level_music.connect("finished", Callable(self,"_on_loop_sound").bind(level_music))
	lobby_music.connect("finished", Callable(self,"_on_loop_lobby").bind(lobby_music))
	lobby_music.play()

# updated comment that does nothing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	
	if current_health == 0 or current_health < 0:
		death()
	
	player_health.text = "Health: " + str(current_health)
	player_gold.text = "Gold: " + str(gold)
	
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
		
	if Input.is_action_pressed("attack"):
		pass
	
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
		
func death():
	fade_to_black.fade_out()
	fade_to_black.color_rect.visible = true
	speed_buffs = []
	defense_buffs = []
	health_buffs = []
	update_defense()
	update_health()
	update_speed()
	attack.update_attack()
	current_health = health
	await get_tree().create_timer(2).timeout 
	cave.play("cave_lobby")
	position.x = 947
	position.y = 810
	fade_to_black.fade_in()
	level_music.stop()
	lobby_music.play()

func damage_player(damage) -> void:
	current_health = current_health - damage

func _on_portal_body_entered(body: Node2D) -> void:
	fade_to_black.fade_out()
	fade_to_black.color_rect.visible = true
	root_node.level += 1
	buff_scene.visible = true
	buff_scene.do_buffs_all()
	update_defense()
	update_health()
	update_speed()
	attack.update_attack()
	portal.reset_portal()
	current_health = health
	await get_tree().create_timer(2).timeout 
	cave.play("cave_level")
	root_node.do_spawning()
	position.x = 947
	position.y = 810
	fade_to_black.fade_in()
	lobby_music.stop()
	level_music.play()
	
func _on_loop_sound():
	level_music.play()
	
func _on_loop_lobby():
	lobby_music.play()
