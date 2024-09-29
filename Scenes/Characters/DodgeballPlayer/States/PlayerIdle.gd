extends State
class_name PlayerIdle

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
	randomize_wander()

func Update(_delta: float) -> void:
	# If the "wander timer is up", randomize the wander
	if wander_time <= 0:
		print("Wander time is up")
		randomize_wander()
	else:
		wander_time -= 1

func Physics_Update(_delta: float) -> void:
	# Apply the movement to the player
	player.move_and_collide(movement[MovementType.Velocity] * movement[MovementType.Max_Speed] * _delta)
