extends Area2D

@onready var player = $"../player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_eddy()

func _process(delta: float) -> void:
	if player.alive == true:
		invisible_eddy()
	else:
		show_eddy()

func show_eddy():
	$eddy_collision.disabled = false
	$eddy_sprite.visible = true
	
func invisible_eddy():
	$eddy_collision.disabled = true
	$eddy_sprite.visible = false
