extends CanvasLayer

@onready var root_node = $".."
@onready var player = $"../player"
@onready var fade_to_black = $"../fade"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("test"):
		fade_to_black.fade_out()
		player.position.x = 947
		player.position.y = 810
		await get_tree().create_timer(2).timeout
		root_node.enable_things()
		fade_to_black.fade_in()
		visible = false


func _on_button_pressed() -> void:
	print("test")
