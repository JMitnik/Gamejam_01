###
# This manager is responsible for guardign the initial settings of the game, such as whether the layers match appropriately.
###
extends Node
class_name GameGuardian

func _ready() -> void:
	check_layers()
	check_required_groups()

###
# Check that the layers in the Game Settings match the enum Settings
###
func check_layers() -> void:
	for i in range(1, 33): # Godot can have at most 33 layers
		var layer_name = ProjectSettings.get_setting("layer_names/2d_physics/layer_" + str(i))

		match i:
			Constants.Layer.Floor:
				assert(layer_name == "floor", "Layer" + str(i) + " should be named" + "Floor")
			Constants.Layer.LeftPlayers:
				assert(layer_name == "left_players", "Layer" + str(i) + " should be named" + "LeftPlayers")
			Constants.Layer.RightPlayers:
				assert(layer_name == "right_players", "Layer" + str(i) + " should be named" + "RightPlayers")
			Constants.Layer.Ball:
				assert(layer_name == "ball", "Layer" + str(i) + " should be named" + "Ball")

func check_required_groups() -> void:
	"""
	This ensures that the groups in the Game Settings actually exist.
	"""
	var groups = [Constants.Group.Players, Constants.Group.Balls]
	
	for group in groups:
		assert(get_tree().has_group(group), "Group " + group + " does not exist. => Please add it in the Game Settings.")
