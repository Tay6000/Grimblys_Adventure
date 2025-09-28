extends AnimatedSprite2D

@onready var monster1_node = load("res://Monster.tscn")
@onready var spawn1 = $"../spawner1"

@export var monster1: PackedScene

var enemies = 0
var level = 0
var spawned_enemies = 0
var current_enemies = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = 0
	enemies = 0
	current_enemies = 0
	play("cave_lobby")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func do_spawning():
	enemies = level*2
	current_enemies = enemies
	spawned_enemies = 0
	for spawned_enemies in range(enemies):
		var x = randi_range(1,4)
		spawn_enemy(spawn1.position)
		await get_tree().create_timer(1).timeout 
		spawned_enemies += 1

	
func reset_cave():
	play("cave_lobby")
	level = 0
	enemies = 0
	
func spawn_enemy(pos):
	print("spawn")
	var instance = monster1.instantiate()
	instance.position = -(pos)
	add_child(instance)
