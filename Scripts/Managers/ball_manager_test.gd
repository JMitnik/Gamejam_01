extends Node

@onready var ball = get_node("/root/Placeholder/Ball")
@onready var player = get_node("/root/Placeholder/TeamBlue/Player")

func _on_player_ball_is_thrown(direction):
	print("Ball is thrown, send instruction to ball")
	ball.be_thrown(direction)

func _ready() -> void:
	print(ball)
	print(player)
	print("testttt")

func _on_ball_player_collision(collider_id):
	#print("Collided with a Player1: " , collider_id)
	#ball.position = player.position
	ball.be_caught()
	print("Collided!")
	player.have_ball = true


func _on_player_moving_with_ball(player_position):
	ball.move_with_player(player_position)
