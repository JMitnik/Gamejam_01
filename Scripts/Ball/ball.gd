extends CharacterBody2D

signal player_collision

@onready var sprite = $BallPivot/Sprite2D
@onready var collision_shape = $CollisionShape2D

@export var initial_velocity = 20

var caught = false
var direction = Vector2(5.0, -10.0).normalized()

func _ready():
	pass
	
func be_caught():
	caught = true
	sprite.position = Vector2(100, 0)
	collision_shape.disabled = true
	

func be_thrown(new_direction, throwspeed):
	#print(position, sprite.position)
	# Set the position of the Ball to the position of the sprite
	position = sprite.global_position
	# Remove the offset
	sprite.position = Vector2(0.0, 0.0)
	#print(position, sprite.position)
	caught = false
	direction = new_direction
	collision_shape.disabled = false

func _physics_process(delta):
	if caught:
		look_at(get_global_mouse_position())
	else: 
		velocity = direction * initial_velocity
		var collision = move_and_collide(velocity)
		if collision:
			velocity *= 0.0
			player_collision.emit(collision.get_collider_id())	
			
func move_with_player(player_position):
	position = player_position
