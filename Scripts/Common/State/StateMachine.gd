class_name StateMachine
extends Node

# Maintain all states of the state machine (which are instances of the State class, and children)
@export var initial_state: State
var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	init_state_children()
	init_first_state()
	print("State machine is ready")

func init_state_children():
	# Get all children of the StateMachine node
	var children = get_children()

	# Iterate over all children, checking if they are instances of the State class, and if so, adding them to the states dictionary
	for child in children:
		if child is State:
			states[child.get_name().to_lower()] = child

			# Connect a child's Transitioned signal to the on_child_transitioned method
			# Aka: if a child sends out a Transitioned signal, the StateMachine will know about it
			child.Transitioned.connect(self.on_child_transitioned)

	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func init_first_state():
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

###
# Executed every frame. Calls the Update method of the current state.
###
func _process(delta: float) -> void:
	if (current_state):
		# Call the Update method of the current state
		current_state.Update(delta)
	else:
		push_warning("No current state set; please set a state or initial state")

###
# Executed every physics frame. Calls the Physics_Update method of the current state.
###
func _physics_process(delta: float) -> void:
	if (current_state):
		# Call the Physics_Update method of the current state
		current_state.Physics_Update(delta)

func on_child_transitioned(state: State, new_state_name: String) -> void:
	# Only allow the current state to transition to a new state
	if state != current_state:
		print("State machine received a transition from a state that is not the current state")
		return

	var next_state = states.get(new_state_name.to_lower())

	if (!next_state):
		push_warning("State machine received a transition to a state that does not exist")
		return

	if (current_state):
		# Call the Exit method of the current state
		current_state.Exit()

	print(next_state.get_name() + " state SHOULD BE entered")
	next_state.Enter()

	current_state = next_state
	# Emit the Transitioned signal when a child state emits its Transitioned signal
	# emit_signal("Transitioned")
