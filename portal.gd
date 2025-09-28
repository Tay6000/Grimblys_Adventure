extends Area2D

func _ready() -> void:
	reset_portal()
	
func show_portal():
	$portal_collision.disabled = false
	$portal_sprite.visible = true
	
func reset_portal():
	$portal_collision.disabled = true
	$portal_sprite.visible = false
