extends Area2D
class_name Ball

signal player_collision

# The `ball_in_court` signal is emitted when the ball passes the "middle wall" and is in the right court
signal ball_in_right_court

@onready var ball_sprite = $BallPivot/SprBall0
@onready var arrow_sprite = $BallPivot/SprArrow1
@onready var collision_shape = $CollisionShape2D
@onready var main_player = get_player()
@onready var current_player_owner = main_player
@onready var _animated_sheet = $CollisionShape2D/AnimatedSprite2D;

@export var ball_speed = 500
@export var sprite_offset_from_player = Vector2(35, 0)
@export var arrow_sprite_offset_from_ball = Vector2(80, 0)

var caught = false
var ball_direction = Vector2(5.0, -10.0).normalized()

func _ready() -> void:
	position = current_player_owner.position
	be_caught(main_player)

func _physics_process(delta):
	if caught:
		position = current_player_owner.position
		look_at(get_global_mouse_position())
	else:
		position += ball_direction * ball_speed * delta

func _on_body_entered(body: PhysicsBody2D) -> void:
	"""
	Consider which collision happened, and act accordingly.
	"""
	if body is DodgeballPlayer:
		hit_dodgeball_player(body)
		return

	if body is Player:
		be_caught(body)
		player_collision.emit()
		return

	# Now we check what the collision layer is
	var collided_layer = body.get_collision_layer()

	if collided_layer == Constants.Layer.Wall:
		# If the ball hits a wall, it should bounce off.
		# Debug: for now, just return the ball
		# be_caught(current_player_owner)
		_animated_sheet.play("squish")
		stop_ball()
		return

	if collided_layer == Constants.Layer.CenterWall:
		print("Center!")
		# If the ball hits the center wall, it should emit a signal to indicate that the ball is in the right court.
		ball_in_right_court.emit('right_side')
		return

	# Else, we have no support for this collision yet!
	push_warning("Unhandled collision with " + body.name)

func hit_dodgeball_player(player: DodgeballPlayer) -> void:
	"""
	If the ball hits a DodgeballPlayer, the player is out.
	"""
	player.destroy()

func stop_ball() -> void:
	"""
	Stop the ball from moving.
	"""
	ball_direction = Vector2.ZERO

func be_caught(catching_player: Player):
	"""
	When a player catches the ball, the ball is caught and the player is the owner of the ball.
	"""
	catching_player.have_ball = true
	
	# Stop the ball from colliding, assign the player as the owner of the ball, and ensure the ball is at the player's position.
	caught = true
	collision_shape.disabled = true
	current_player_owner = catching_player
	ball_sprite.position = sprite_offset_from_player

	# Show the arrow sprite
	arrow_sprite.visible = true
	arrow_sprite.position = sprite_offset_from_player + arrow_sprite_offset_from_ball

func be_thrown(new_direction: Vector2, _throwspeed):
	"""
	When a player throws the ball, the ball is thrown in the direction of the mouse.
	"""
	# Set the position of the Ball to the position of the sprite
	position = ball_sprite.global_position
	
	# Remove the offset
	ball_sprite.position = Vector2(0.0, 0.0)

	# Set the direction of the ball
	ball_direction = new_direction
	caught = false

	# Enable the collision shape and hide the arrow sprite
	arrow_sprite.visible = false
	collision_shape.disabled = false


func get_player() -> Player:
	"""
	Fetch the main player from the scene.
	TODO: Convert this to a singleton method (or a utility method).
	"""
	# Get all nodes with group "Players". Return one.
	var players = get_tree().get_nodes_in_group("Players")

	# If there are no players, raise an error.
	assert(players.size() > 0, "No players found in the scene.")

	# If there are multiple players, raise an error.
	assert(players.size() > 1, "Multiple players found in the scene.")

	# This is a node2d; now get the Player class node.
	var player_node2d = players[0]
	var player = player_node2d.get_node("Player")
	assert(player is Player, "Found node is not of type Player.")

	# Return the player.
	return player
