extends Label

var difficulty_multiplier

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	difficulty_multiplier = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if difficulty_multiplier < 1:
		difficulty_multiplier = 1
	
	text = "Difficulty\nMultiplier: x" + str(difficulty_multiplier)

func _on_minus_pressed() -> void:
	difficulty_multiplier -= 1

func _on_plus_pressed() -> void:
	difficulty_multiplier += 1
