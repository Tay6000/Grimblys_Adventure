extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	visible = false
	color_rect.visible = false
	animation_player.animation_finished.connect(_invisible)
	$ColorRect.mouse_filter = 2
	
func _invisible():
	visible = false
	color_rect.visible = false
	
func fade_out():
	visible = true
	color_rect.visible = true
	animation_player.play("fade_out")

func fade_in():
	visible = true
	color_rect.visible = true
	animation_player.play("fade_in")
