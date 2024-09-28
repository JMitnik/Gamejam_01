extends CharacterBody2D

@export var SPEED = 130.0

#Used for movement smoothing later
@export var ACCEL = 10.0

#player moves across a Vector2..
var input : Vector2

func get_input():
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	#normalized means that no matter what direction you go in, it will always be the same speed
	return input.normalized()
	
func _physics_process(delta: float) -> void:
	var playerInput = get_input()
	
	#lerp is short for linear interpolation; input*speed = topspeed & delta & ACCEL smoothens movement, lower is more lag higher is more snap.
	velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
	
	move_and_slide()
