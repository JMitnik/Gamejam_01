extends CharacterBody2D
class_name DodgeballPlayer

# Outputs: BallInCourt signal
signal ball_in_court(side: String)

@onready var ball: Ball = get_ball()

@export var team_name: String = 'red'
@export var move_speed: float = 100.0
@export var change_direction_time: float = 2.0
#@export var movement_bounds: Rect2 = Rect2(0, 0, 1000, 1000);
@onready var winning_state_manager: WinningStateManager = get_node("/root/Game/Managers/WinningStateManager")
@onready var state_machine: DodgeballStateMachine = $"%State Machine"
@onready var _animated_sheet: AnimatedSprite2D = $AnimatedSprite2D
@onready var _static_sheet: Sprite2D = $Sprite2D

var current_direction: Vector2 = Vector2.ZERO
var time_since_last_direction_change: float = 0.0

func _ready():
	_animated_sheet.hide()
	# If the ball is in right court, connect the `is_ball_in_court` handler to it
	ball.ball_in_right_court.connect(state_machine.handle_ball_in_court)

func _input(event):
	pass
	
func _physics_process(_delta):
	pass

func hit():
	# Hardcode:
	# Implement hit behavior here
	print("AI Player hit!")

func destroy():
	# Implement destruction behavior here
	winning_state_manager.kill_player(self, team_name)

	# Hide main sheet and show static sheet
	show_hit_animation()
	queue_free()

func show_hit_animation():
	# Implement hit animation here
	# Hide main sheet and show static sheet
	_animated_sheet.play('default')
	_static_sheet.hide()

	# Wait for 2 seconds before destroying the player
	await get_tree().create_timer(2.0).timeout


func is_ball_in_court(side: String):
	emit_signal("BallInCourt", side)


func get_ball() -> Ball:
	"""
	Fetch the ball from the scene.
	TODO: Convert this to a singleton method (or a utility method).
	"""
	# Get all nodes with group "Players". Return one.
	var balls = get_tree().get_nodes_in_group("Balls")

	# If there are no players, raise an error.
	print(balls.size())
	assert(balls.size() > 0, "No balls found in the scene.")

	# If there are multiple players, raise an error.
	assert(balls.size() == 1, "Multiple balls found in the scene.")

	# This is a node2d; now get the Player class node.
	var found_ball := balls[0] as Ball
	assert(found_ball is Ball, "Found node is not of type Ball.")

	# Return the player.
	return found_ball
