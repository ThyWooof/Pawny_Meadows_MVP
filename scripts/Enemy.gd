extends BaseEnemy

enum state {IDLE, MOVING, ATTACKING}
var current_state = state.IDLE

func _physics_process(_delta: float) -> void:
	if target != null: 
		var distance = global_position.distance_to(target.global_position)
		
		match current_state:
			state.IDLE:
				if distance > attack_range:
					current_state = state.MOVING
				elif distance <= attack_range:
					current_state = state.ATTACKING
			
			state.MOVING:
				if distance <= attack_range:
					current_state = state.ATTACKING
				else:
					move_to(target.global_position)
			
			state.ATTACKING:
				if distance > attack_range:
					current_state = state.MOVING
				else:
					stop_moving()
					sprite.play("attack")
	else:
		current_state = state.IDLE
		stop_moving()
		sprite.play("idle")
	move_and_slide()
