class_name WinningStateManager
extends Node

var team_red = []
var team_blue = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var red_nodes = get_team_nodes('TeamRed')
	var blue_nodes = get_team_nodes('TeamBlue')
	print(red_nodes)
	pass # Replace with function body.

func kill_player(String teamName) -> void:
	# Call it: var winning_state_manager = get_node("/root/WinningStateManager")
	#winning_state_manager.kill_player("TeamRed")
	


func get_team_nodes(team_name: String) -> Array:
	var team_nodes = get_tree().get_nodes_in_group(team_name)
	return team_nodes


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_alive_blue_player_count():
	return 
