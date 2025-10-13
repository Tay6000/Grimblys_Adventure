extends CharacterBody2D

@onready var player = $"../player"
@onready var indicator = player.get_child(4)

var type
var speed
var lifespan
var timer
var damage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 300
	lifespan = 3
	rotation = indicator.rotation
	velocity = Vector2(speed, 0).rotated(rotation)
	if player.powers.has("bigger fireball"):
		damage = player.attack * 2
	elif player.powers.has("more fireballs"):
		damage = player.attack * 0.3
	else:
		damage = player.attack

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
	lifespan -= 0.1
	if lifespan == 0:
		queue_free()
	if !player.alive:
		queue_free()

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() is Monster:
		area.get_parent().take_damage(damage, "fire")
		queue_free()
