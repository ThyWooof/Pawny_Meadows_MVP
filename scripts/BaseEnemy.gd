class_name BaseEnemy
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var speed: float = 75.0
@export var attack_range: float = 60.0
@export_enum("allies", "pawn") var target_group: String = "allies"

var target: CharacterBody2D

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group(target_group):
		if target == null:
			target = body as CharacterBody2D
			print("Target acquired: ", target.name)

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group(target_group):
		if body == target:
			target = null
			print("Target lost: ", body.name)

func move_to(target_position: Vector2) -> void:
	var direction = global_position.direction_to(target_position)
	
	velocity = direction * speed
			
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
			
	sprite.play("run")

func stop_moving() -> void:
	velocity = Vector2.ZERO
