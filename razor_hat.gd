extends Area2D

@onready var player = $".."

var active

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$razor_sprite.visible = false
	$razor_collision.disabled = true
	active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player.powers.has("razor"):
		active = true
	
	if active == true:
		$razor_sprite.visible = true
		$razor_collision.disabled = false
	else:
		$razor_sprite.visible = false
		$razor_collision.disabled = true
	
	rotate(0.1)
	$razor_sprite.rotate(0.1)
	$razor_collision.rotate(0.1)

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() is Monster:
		area.get_parent().take_damage(float(player.attack) / 4.0)
