extends Control

@onready var volume_slider = $MarginContainer/VBoxContainer/volume
@onready var resolution_selector = $MarginContainer/VBoxContainer/resolution
@onready var pause_menu = $"../pause"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	volume_slider.value = 15
	resolution_selector.selected = 2
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc") && visible == true:
		pause_menu.visible = true
		visible = false


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)

func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1280,720))
