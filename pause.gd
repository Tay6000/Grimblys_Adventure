extends Control

@onready var player = $"../player"
@onready var quit_button = $MarginContainer/VBoxContainer/quit
@onready var resume_button = $MarginContainer/VBoxContainer/resume
@onready var settings_button = $MarginContainer/VBoxContainer/settings
@onready var settings_menu = $"../settings"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.alive == false:
		quit_button.text = "Quit"
	else:
		quit_button.text = "Exit"


func _on_resume_pressed() -> void:
	get_parent().pause_menu()


func _on_quit_pressed() -> void:
	if quit_button.text == "Quit":
		get_tree().quit()
	else:
		get_parent().pause_menu()
		player.death()

func _on_settings_pressed() -> void:
	visible = false
	settings_menu.visible = true
