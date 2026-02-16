extends Node2D

@export var move_speed: float = 200.0

func _process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Optional diagonal normalization (Scope Creep Challenge)
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
	
	position += input_vector * move_speed * delta
