class_name AnyCharacter
extends Node2D

@export var team_name: String = "TeamRed"
# Assuming there is always a Managers/WinningStateManager
@onready var winning_state_manager: WinningStateManager = get_node("/Managers/WinningStateManager")

func hit():
	winning_state_manager.kill_player(self, team_name)
