class_name State
extends Node

# A signal that is emitted when the state is entered.
signal Transitioned

###
# Called when the state is entered.
###
func Enter():
	pass

###
# Called when the state is exited.
###
func Exit():
	pass

###
# Called every frame.
###
func Update(_delta: float):
	pass

###
# Called every physics frame.
###
func Physics_Update(_delta: float):
	pass
