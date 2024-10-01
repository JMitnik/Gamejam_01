extends Node

@onready var ball = get_node("/root/Game/BallManager/Ball")
@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	pass

func _on_player_ball_is_thrown(direction):
	ball.be_thrown(direction, -1)

func _on_ball_player_collision():
	player.have_ball = true
