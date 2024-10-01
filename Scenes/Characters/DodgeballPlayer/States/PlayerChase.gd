extends State
class_name PlayerChase

@onready var ball: Ball = look_for_ball()
@export var player: DodgeballPlayer

enum MovementType {
	Velocity,
	Acceleration,
	Max_Speed,
	Deceleration,
}

var wander_time: float
var movement: Dictionary = {
	[MovementType.Velocity]: Vector2.ZERO,
	[MovementType.Acceleration]: Vector2.ZERO,
	[MovementType.Max_Speed]: 0,
	[MovementType.Deceleration]: 0,
}

func randomize_wander() -> void:
	movement[MovementType.Velocity] = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	movement[MovementType.Acceleration] = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	movement[MovementType.Max_Speed] = randf_range(50, 100)
	movement[MovementType.Deceleration] = randf_range(1, 5)

	wander_time = randi_range(20, 70)

func Enter() -> void:
	print("PlayerChase state entered")
	update_chase_direction()

func Exit() -> void:
	print("PlayerChase state exited")

func Update(_delta: float) -> void:
	pass
	# If the "wander timer is up", randomize the wander
	#if wander_time <= 0:
		#randomize_wander()
	#else:
		#wander_time -= 1

###
# Executed every physics frame.
# Note: This will actually apply the physics to the player
###
func Physics_Update(_delta: float) -> void:
	update_chase_direction()
	player.move_and_slide()
	pass
	# Apply the movement to the player
	#player.move_and_collide(movement[MovementType.Velocity] * movement[MovementType.Max_Speed] * _delta)

func handle_ball_in_court(_side: String):
	print("Should emit chase!")
	
func update_chase_direction() -> void:
	if ball and player:
		var direction = (ball.global_position - player.global_position).normalized()
		player.velocity = direction * 150.0

func look_for_ball() -> Ball:
	# Look for the ball in the scene
	var balls = get_tree().get_nodes_in_group("Balls")
	if balls.size() == 0:
		push_error("No balls found in the scene.")
		return null

	return balls[0] as Ball
