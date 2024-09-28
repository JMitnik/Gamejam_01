extends CharacterBody2D

signal throw_ball
var have_ball: bool = false

func _physics_process(delta):
	if Input.is_action_just_pressed("throw_ball") and have_ball:
		var player_position = global_position
		var mouse_position = get_global_mouse_position()
		
		# Calculate the direction vector
		var direction = mouse_position - player_position
		direction = direction.normalized()
		
		throw_ball.emit(direction)
		print("direction from player", direction)
		have_ball = false
