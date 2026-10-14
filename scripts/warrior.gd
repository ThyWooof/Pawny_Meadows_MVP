extends BaseUnit

enum State {IDLE, MOVING}
var current_state = State.IDLE

func _physics_process(_delta: float) -> void:
	var target_position = get_formation_position()
	
	match current_state:
		State.MOVING:
			if global_position.distance_to(target_position) <= STOP_DISTANCE:
				current_state = State.IDLE
				stop_moving()
			else:
				move_to(target_position)
		
		State.IDLE:
			if global_position.distance_to(target_position) > STOP_DISTANCE:
				current_state = State.MOVING
			else:
				stop_moving()
	
	move_and_slide()
