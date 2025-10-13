extends Area2D

@onready var monster1_node = load("res://Monster.tscn")
@onready var player = get_parent()
@onready var root_node = $"../.."

var aspect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$attack_sprite.visible = false
	$attack_collision.set_deferred("disabled", true)
	$attack_sprite.play("slash")
	aspect = "null"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player.powers.has("fire"):
		aspect = "fire"
		$attack_sprite.modulate = Color(1, 0, 0)
	elif player.powers.has("ice"):
		aspect = "ice"
		$attack_sprite.modulate = Color(0, 1, 1)
	elif player.powers.has("shock"):
		aspect = "shock"
		$attack_sprite.modulate = Color(1, 1, 0)
	
	if Input.is_action_just_pressed("attack") && root_node.paused == false:
		
		if player.direction == "back":
			rotation = 0
		elif player.direction == "front":
			rotation = 3.14159
		elif player.direction == "right":
			rotation = 1.5708
		elif player.direction == "left":
			rotation = -1.5708
		
		$attack_sprite.visible = true
		$attack_sprite.play("slash")
	
	if $attack_sprite.frame > 2 && $attack_sprite.frame < 8:
		$attack_collision.disabled = false
	else:
		$attack_collision.disabled = true


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() is Monster:
		area.get_parent().take_damage(player.attack, aspect)


func _on_attack_sprite_animation_finished() -> void:
	$attack_sprite.stop()
	$attack_sprite.visible = false
