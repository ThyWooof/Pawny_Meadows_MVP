extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 200

var facing_direction: Vector2 = Vector2.RIGHT

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()
	
	if direction == Vector2.ZERO:
		sprite.play("idle")
	else: 
		facing_direction = direction
		
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
		
		sprite.play("run")
