extends Area2D

signal player_collision

@onready var ball_sprite = $BallPivot/SprBall0
@onready var arrow_sprite = $BallPivot/SprArrow1
@onready var collision_shape = $CollisionShape2D

@export var initial_speed = 100
@export var sprite_offset_from_player = Vector2(35, 0)
@export var arrow_sprite_offset_from_ball = Vector2(80, 0)

var caught = false
var ball_direction = Vector2(5.0, -10.0).normalized()
var owned_by_player = null

func _ready():
	# Change the direction of a ball to a random direction on a circle
	pass
	
func be_caught(catching_player):
	caught = true
	collision_shape.disabled = true
	
	owned_by_player = catching_player
	ball_sprite.position = sprite_offset_from_player
	
	arrow_sprite.visible = true
	arrow_sprite.position = sprite_offset_from_player + arrow_sprite_offset_from_ball

func be_thrown(new_direction):
	
	# Set the position of the Ball to the position of the sprite
	position = ball_sprite.global_position
	# Remove the offset
	ball_sprite.position = Vector2(0.0, 0.0)
	ball_direction = new_direction
	
	caught = false
	arrow_sprite.visible = false
	collision_shape.disabled = false

func _physics_process(delta):
	if caught:
		position = owned_by_player.position
		look_at(get_global_mouse_position())
	else: 
		position += ball_direction * initial_speed * delta
			
func _on_body_entered(body):
	if body.has_method("throw_ball"):
		if true: # If a player catches the ball
			be_caught(body)
			player_collision.emit()
		else:
			print("Put the logic where a player dies")

	
