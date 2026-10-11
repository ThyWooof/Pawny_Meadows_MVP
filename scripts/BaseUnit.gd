class_name BaseUnit
extends CharacterBody2D

@onready var pawn: CharacterBody2D = get_tree().get_first_node_in_group("pawn")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var formation_offset: Vector2 = Vector2(50, 0)

const SPEED = 150
const STOP_DISTANCE = 5.0
