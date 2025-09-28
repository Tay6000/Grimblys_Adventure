extends Area2D

@onready var root_node = $".."

func _ready() -> void:
	reset_portal()
	
func _process(delta) -> void:
	if root_node.current_enemies == 0:
		show_portal()
	else:
		reset_portal()

func show_portal():
	$portal_collision.disabled = false
	$portal_sprite.visible = true
	
func reset_portal():
	$portal_collision.disabled = true
	$portal_sprite.visible = false
