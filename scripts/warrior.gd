extends BaseUnit

enum state {IDLE, MOVING}
var current_state = state.IDLE

func _physics_process(_delta: float) -> void:
	var target_position = get_formation_position()
	
	match current_state:
		state.MOVING:
			if global_position.distance_to(target_position) <= STOP_DISTANCE:
				current_state = state.IDLE
				stop_moving()
			else:
				move_to(target_position)
		
		state.IDLE:
			if global_position.distance_to(target_position) > STOP_DISTANCE:
				current_state = state.MOVING
			else:
				stop_moving()
	
	move_and_slide()
