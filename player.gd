extends Node2D

# Configurable speed and smoothing
@export var move_speed: float = 400.0
@export var acceleration: float = 16.0
@export var friction: float = 12.0

# Current velocity of the player
var velocity: Vector2 = Vector2.ZERO

func _process(delta):
	var input_vector = Vector2.ZERO
	
	# Arrow key input
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Normalize diagonal movement so speed is consistent
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
	
	# Smooth acceleration and deceleration
	if input_vector != Vector2.ZERO:
		var target_velocity = input_vector * move_speed
		velocity = velocity.lerp(target_velocity, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
	
	# Update position with delta for frame independence
	position += velocity * delta

	# keep player inside window bounds
	position.x = clamp(position.x, 0, 1152)
	position.y = clamp(position.y, 0, 648)
