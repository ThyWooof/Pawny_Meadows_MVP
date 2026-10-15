extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var target: CharacterBody2D
const SPEED = 75

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("allies"):
		if target == null:
			target = body as CharacterBody2D
			print("Target acquired: ", target.name)

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("allies"):
		if body == target:
			target = null
			print("Target lost: ", body.name)

func _physics_process(delta: float) -> void:
	if target != null: 
		const ATTACK_RANGE = 60.0
		var distance = global_position.distance_to(target.global_position)
		var direction = global_position.direction_to(target.global_position)
		
		if distance <= ATTACK_RANGE:
			velocity = Vector2.ZERO
			sprite.play("attack")
			
		else:
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
