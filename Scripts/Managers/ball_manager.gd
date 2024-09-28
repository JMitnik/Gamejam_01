extends Node

@onready var ball = get_node("%Ball")
@onready var player = get_node("/root/Game/BallManager/Player")

func _on_player_ball_is_thrown(direction):
	print("Ball is thrown, send instruction to ball")
	ball.be_thrown(direction)

func _on_ball_player_collision():
	player.have_ball = true

#func _on_player_moving_with_ball(player_position):
	#ball.move_with_player(player_position)
