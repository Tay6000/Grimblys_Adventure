extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.visible = false
	animation_player.animation_finished.connect(_invisible)
	
func _invisible():
	color_rect.visible = false
	
func fade_out():
	color_rect.visible = true
	animation_player.play("fade_out")

func fade_in():
	color_rect.visible = true
	animation_player.play("fade_in")
