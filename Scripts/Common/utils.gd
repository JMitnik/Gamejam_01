extends Node
class_name Utils

func get_player() -> Player:
	# Get all nodes with group "Players". Return one.
	var players = get_tree().get_nodes_in_group("Players")
	
	# If there are no players, raise an error.
	assert(players.size() > 0, "No players found in the scene.")

	# If there are multiple players, raise an error.
	assert(players.size() == 1, "Multiple players found in the scene.")

	# This is a node2d; now get the Player class node.
	var player_2d_node = players[0]
	var player = player_2d_node as Player
	assert(player is Player, "Found node is not of type Player.")


	# Return the player.
	return players[0]
