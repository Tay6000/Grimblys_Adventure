extends CharacterBody2D

@onready var cave = $"../cave"
@onready var fade_to_black = $"../fade"
@onready var portal = $"../portal"
@onready var player_health = $"../player_health"
@onready var buff_scene = $"../buff_scene"
@onready var level_music = $"../level_music"
@onready var lobby_music = $"../lobby_music"
@onready var shop_music = $"../shop_music"
@onready var player_gold = $"../player_gold"
@onready var root_node = $".."
@onready var attack_node = $attack
@onready var shop = $"../shop"

var direction = "back"
@export var base_speed : int
@export var base_health : int
@export var base_defense : int
@export var base_attack : int
var speed
var health
var defense
var attack
var speed_upgrades
var health_upgrades
var defense_upgrades
var attack_upgrades
var speed_buffs
var health_buffs
var defense_buffs
var attack_buffs
var current_health
var gold
var screen_size
var alive
var powers
var abilities
var dashing
var dash_cooldown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_new_player()
	update_defense()
	update_health()
	update_speed()
	current_health = health
	lobby_music.play()
	$fireball_indicator.visible = false
	dashing = false
	dash_cooldown = 0

# updated comment that does nothing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	
	if current_health == 0 or current_health < 0:
		death()
	
	player_health.text = "Health: " + str(int(current_health))
	player_gold.text = "Gold: " + str(int(gold))
	
	if powers.has("fireballs"):
		$fireball_indicator.visible = true
	
	if !dashing:
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
	
	if abilities.has("dash") && Input.is_action_just_pressed("dash") && dash_cooldown < 0:
		dash()
	dash_cooldown -= 0.05
	
	move_and_slide()

func update_speed() -> void:
	speed = base_speed
	for i in speed_upgrades:
		speed = speed + i
	for i in speed_buffs:
		var speed_add = round(speed * i)
		speed = speed + speed_add
		
func update_health() -> void:
	health = base_health
	for i in health_upgrades:
		health = health + i
	for i in health_buffs:
		var health_add = round(health * i)
		health = health + health_add
		
func update_defense() -> void:
	defense = base_defense
	for i in defense_upgrades:
		defense = defense + i
	for i in defense_buffs:
		var defense_add = round(defense * i)
		defense = defense + defense_add
		
func update_attack():
	attack = base_attack
	for i in attack_upgrades:
		attack += i
	for i in attack_buffs:
		var attack_add = round(attack * i)
		attack = attack + attack_add
		
func create_new_player():
	base_speed = 200
	base_health = 3
	base_defense = 0
	base_attack = 2
	speed = base_speed
	health = base_health
	defense = base_defense
	attack = base_attack
	speed_upgrades = []
	health_upgrades = []
	defense_upgrades = []
	attack_upgrades = []
	speed_buffs = []
	health_buffs = []
	defense_buffs = []
	attack_buffs = []
	gold = 0
	alive = false
	powers = []
	abilities = []
	
func death():
	fade_to_black.fade_out()
	fade_to_black.color_rect.visible = true
	alive = false
	position.x = 947
	position.y = 810
	root_node.current_enemies = 3000
	root_node.level = 0
	speed_buffs = []
	defense_buffs = []
	health_buffs = []
	attack_buffs = []
	update_defense()
	update_health()
	update_speed()
	update_attack()
	current_health = health
	await get_tree().create_timer(2).timeout
	root_node.current_enemies = 0
	cave.play("cave_lobby")
	buff_scene.visible = false
	buff_scene.buffs_active = false
	buff_scene.deactivate_buttons()
	position.x = 947
	position.y = 810
	fade_to_black.fade_in()
	level_music.stop()
	lobby_music.play()

func damage_player(damage) -> void:
	var plyr_damage = round(damage - defense)
	if plyr_damage > 0:
		current_health = current_health - plyr_damage
	else:
		current_health -= 1

func _on_portal_body_entered(body: Node2D) -> void:
	fade_to_black.fade_out()
	fade_to_black.color_rect.visible = true
	position.x = 947
	position.y = 810
	root_node.current_enemies = 30000
	update_defense()
	update_health()
	update_speed()
	update_attack()
	current_health = health
	alive = true
	await get_tree().create_timer(2).timeout 
	cave.play("cave_level")
	root_node.current_enemies = 0
	root_node.level += 1
	root_node.do_spawning()
	root_node.do_fireballs()
	buff_scene.visible = false
	buff_scene.buffs_active = false
	buff_scene.deactivate_buttons()
	position.x = 947
	position.y = 810
	fade_to_black.fade_in()
	lobby_music.stop()
	level_music.play()
	
func _on_level_music_finished():
	level_music.play()
	
func _on_lobby_music_finished():
	lobby_music.play()

func _on_eddy_body_entered(body: Node2D) -> void:
	fade_to_black.fade_out()
	await get_tree().create_timer(2).timeout
	position.x = 947
	position.y = 810
	fade_to_black.fade_in()
	shop.visible = true
	root_node.disable_things()
	shop_music.play()

func dash():
	dashing = true
	$player_collision.disabled = true
	$PlayerSprite.play("grimbly_dash")
	if direction == "back":
		velocity.y = -1
	elif  direction == "front":
		velocity.y = 1
	elif direction == "right":
		velocity.x = 1
	elif direction == "left":
		velocity.x = -1
	velocity = velocity.normalized() * speed * 2
	move_and_slide()
	await get_tree().create_timer(0.3).timeout
	$player_collision.disabled = false
	dashing = false
	dash_cooldown = 2
