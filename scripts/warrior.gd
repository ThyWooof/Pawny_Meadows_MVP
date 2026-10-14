extends BaseUnit

enum State {IDLE, MOVING}
var current_state = State.IDLE

func _physics_process(_delta: float) -> void:
	var rotated_offset = formation_offset.rotated(pawn.facing_direction.angle())
	var target_position = pawn.global_position + rotated_offset
	var direction = global_position.direction_to(target_position)
	
	match current_state:
		State.MOVING:
			if global_position.distance_to(target_position) <= STOP_DISTANCE:
				current_state = State.IDLE
				velocity = Vector2.ZERO
			else:
				velocity = direction * SPEED
				
				if direction.x < 0:
					sprite.flip_h = true
				elif direction.x > 0:
					sprite.flip_h = false
				
				sprite.play("run")
		
		State.IDLE:
			if global_position.distance_to(target_position) > STOP_DISTANCE:
				current_state = State.MOVING
			else:
				velocity = Vector2.ZERO
				sprite.play("idle")
	
	move_and_slide()
