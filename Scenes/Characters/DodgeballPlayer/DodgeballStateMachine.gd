extends StateMachine
class_name DodgeballStateMachine



func handle_ball_in_court(side: String):
	if current_state and current_state.has_method("handle_ball_in_court"):
		current_state.handle_ball_in_court(side)
