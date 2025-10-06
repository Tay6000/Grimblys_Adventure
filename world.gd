extends Node2D

@onready var monster1_node = load("res://Monster.tscn")
@onready var spawn1 = $spawner1
@onready var spawn2 = $spawner2
@onready var spawn3 = $spawner3
@onready var spawn4 = $spawner4

@export var monster1: PackedScene

var enemies = 0
var level = 0
var spawned_enemies = 0
var current_enemies = 0
var shop = load("res://shop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = 0
	enemies = 0
	current_enemies = 0
	$cave.play("cave_lobby")
	$buff_scene.visible = false
	$shop.visible = false
	enable_things()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $buff_scene.buffs_active == false && current_enemies == 0 && level > 0:
		$buff_scene.visible = true
		$buff_scene.do_buffs_all()
	
	if $player.alive == false:
		$player_health.visible = false
		$player_gold.visible = true
	else:
		$player_health.visible = true
		$player_gold.visible = false

func do_spawning():
	enemies = level*2
	current_enemies = enemies
	spawned_enemies = 0
	for spawned_enemies in range(enemies):
		var x = randi_range(1,4)
		if x == 1:
			spawn_enemy(spawn1.position)
		elif x == 2:
			spawn_enemy(spawn2.position)
		elif x == 3:
			spawn_enemy(spawn3.position)
		else:
			spawn_enemy(spawn4.position)
		await get_tree().create_timer(1).timeout 
		spawned_enemies += 1

func reset_cave():
	$cave.play("cave_lobby")
	level = 0
	enemies = 0

func spawn_enemy(pos):
	var instance = monster1.instantiate()
	instance.position = (pos)
	add_child(instance)

func disable_things():
	$cave.visible = false
	$portal.visible = false
	$portal/portal_collision.disabled = true
	$player.visible = false
	$player/player_collision.disabled = true
	$attack/CollisionShape2D.disabled = true
	$eddy.visible = false
	$eddy/eddy_collision.disabled = true
	$lobby_music.stop()
	$level_music.stop()

func enable_things():
	$cave.visible = true
	$portal.visible = true
	$portal/portal_collision.disabled = false
	$player.visible = true
	$player/player_collision.disabled = false
	$attack/CollisionShape2D.disabled = false
	$eddy.visible = true
	$eddy/eddy_collision.disabled = false
	$lobby_music.play()
	$level_music.stop()
