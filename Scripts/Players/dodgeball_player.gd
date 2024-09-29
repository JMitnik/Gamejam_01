extends CharacterBody2D
class_name DodgeballPlayer

@export var team_name: String = 'red'
@export var move_speed: float = 100.0
@export var change_direction_time: float = 2.0
#@export var movement_bounds: Rect2 = Rect2(0, 0, 1000, 1000);
@onready var winning_state_manager: WinningStateManager = get_node("/root/Game/Managers/WinningStateManager")

var current_direction: Vector2 = Vector2.ZERO
var time_since_last_direction_change: float = 0.0

func _ready():
	print("Hello")

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_F:
			if event.pressed and not event.echo:
				destroy()
			elif not event.pressed:
				print("F key was just released")

func _physics_process(delta):
	pass

func hit():
	# Hardcode:
	# Implement hit behavior here
	print("AI Player hit!")

func destroy():
	# Implement destruction behavior here
	winning_state_manager.kill_player(self, team_name)
	queue_free()
