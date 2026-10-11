extends CharacterBody2D
@onready var pawn: CharacterBody2D = get_tree().get_first_node_in_group("pawn")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var formation_offset: Vector2 = Vector2(-80, 0)

const SPEED = 150
const STOP_DISTANCE = 5.0

func _physics_process(_delta: float) -> void:
	var rotated_offset = formation_offset.rotated(pawn.facing_direction.angle())
	var target_position = pawn.global_position + rotated_offset
	var direction = global_position.direction_to(target_position)
	
	if global_position.distance_to(target_position) > STOP_DISTANCE:
		velocity = direction * SPEED
		
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
		
		sprite.play("run")
	else:
		velocity = Vector2.ZERO
		sprite.play("idle")
	
	move_and_slide()
