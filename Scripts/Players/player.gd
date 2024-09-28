extends CharacterBody2D

@export var SPEED = 130.0
#Used for movement smoothing later
@export var ACCEL = 10.0

signal throw_ball
var have_ball: bool = false
#used for dashing
var SPEEDCARRY = SPEED
var CANDASH = 1
var ISDASHING = false
@export var MOUSEDASH = false;
@export var DASHSPEEDMULT = 1.2
@export var DASHTIMER = 0.1
@export var CANDASHTIMER = 2

#player moves across a Vector2..
var input : Vector2
var dashinput : float
var dashchecker : int

func get_move_input():
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if Input.get_action_strength("dash") && CANDASH == 1:
			dash()
	
	#normalized means that no matter what direction you go in, it will always be the same speed
	return input.normalized()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("throw_ball") and have_ball:
		var player_position = global_position
		var mouse_position = get_global_mouse_position()
		
		# Calculate the direction vector
		var direction = mouse_position - player_position
		direction = direction.normalized()
		
		throw_ball.emit(direction)
		print("direction from player", direction)
		have_ball = false

	if MOUSEDASH == true:
		if ISDASHING == true:
			var mousedirection = get_global_mouse_position()
			velocity = (mousedirection-global_position).normalized() * SPEED
			move_and_slide()
		else:
			var playerInput = get_move_input()
				#lerp is short for linear interpolation; input*speed = topspeed & delta & ACCEL smoothens movement, lower is more lag higher is more snap.
			velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
			move_and_slide()
	else: 
		var playerInput = get_move_input()
		#lerp is short for linear interpolation; input*speed = topspeed & delta & ACCEL smoothens movement, lower is more lag higher is more snap.
		velocity = lerp(velocity, playerInput * SPEED, delta * ACCEL)
		move_and_slide()
		
func dash():
	#note, I'm too lazy and am just using the ball as a visual instead of creating a new one. Below is the code actually doing the work.
	SPEED = SPEED * DASHSPEEDMULT
	ISDASHING = true
	await get_tree().create_timer(DASHTIMER).timeout
	ISDASHING = false
	CANDASH = 0
	SPEED = SPEEDCARRY

	await get_tree().create_timer(CANDASHTIMER).timeout
	CANDASH=1
