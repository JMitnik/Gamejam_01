extends Node

class_name Constants

# Collision Layers
enum Layer {
	Floor = 10,
	LeftPlayers = 11,
	RightPlayers = 12,
	Ball = 13,
	Player = 14,
	Wall = 16384,
	CenterWall = 32768,
}

# Groups as constants
class Group:
	const Players = "Players"
	const Balls = "Balls"
