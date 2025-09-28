extends Area2D

@onready var root_node = $"../cave"

func _ready() -> void:
	reset_portal()
	
func _process(delta) -> void:
	if root_node.enemies == 0:
		show_portal()
	
func show_portal():
	$portal_collision.disabled = false
	$portal_sprite.visible = true
	
func reset_portal():
	$portal_collision.disabled = true
	$portal_sprite.visible = false
