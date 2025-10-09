extends Button

@onready var hover_texture = load("res://icon.svg")
@onready var still_texture = load("res://Sprites/eddy.png")

var multiplier : float
var buff : int

var in_area

func _ready() -> void:
	in_area = false
	icon = still_texture
	
func _on_mouse_entered() -> void:
	in_area = true
	icon = hover_texture
	
func _on_mouse_exited() -> void:
	in_area = false
	icon = still_texture
