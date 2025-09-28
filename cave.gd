extends AnimatedSprite2D

@export var monster1: PackedScene

var enemies = 0
var level = 0
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
