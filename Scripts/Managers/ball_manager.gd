extends Node

@onready var ball = get_node("%Ball")
@onready var player = get_node("/root/Game/BallManager/Player")

func _on_player_ball_is_thrown(direction, throwspeed):
	#print("Ball is thrown, send instruction to ball")
	ball.be_thrown(direction, throwspeed)


func _on_ball_player_collision(collider_id):
	#print("Collided with a Player1: " , collider_id)
	#ball.position = player.position
	ball.be_caught()
	player.have_ball = true


func _on_player_moving_with_ball(player_position):
	#print(player_position)
	ball.move_with_player(player_position)
