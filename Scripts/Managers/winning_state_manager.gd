class_name WinningStateManager
extends Node

var team_red = []
var team_blue = []
@onready var final_screen: Sprite2D = get_node("/root/Game/FinalScreen/Sprite2D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var red_nodes = get_team_nodes('TeamRed')
	var blue_nodes = get_team_nodes('TeamBlue')
	final_screen.hide()

func update_team_count():
	team_red = get_team_nodes('TeamRed')
	team_blue = get_team_nodes('TeamBlue')
	print("Red team count: ", team_red.size())
	print("Blue team count: ", team_blue.size())

func get_team_nodes(team_name: String) -> Array:
	var team_nodes = get_tree().get_nodes_in_group(team_name)
	return team_nodes

func kill_player(unit: Node2D, team_name: String) -> void:
	print("Player from " + team_name + " was killed")
	
	# Remove the player from our team arrays
	if team_name == "TeamRed":
		team_red.erase(unit)
	elif team_name == "TeamBlue":
		team_blue.erase(unit)
	
	update_team_count()
	check_win_condition()

func check_win_condition():
	if team_red.size() == 1:
		print("Blue team wins!")
		
		# Show Node named FinalScreen
		final_screen.show()	
		
		# Implement win logic for Blue team
	elif team_blue.size() == 1:
		print("Red team wins!")
		# Implement win logic for Red team
