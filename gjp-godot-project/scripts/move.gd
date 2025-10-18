extends Node
class_name Mover

@onready var n = get_parent()

@export var direction : = Vector2.ZERO
@export var speed : = 1.0
@export var acceleration : = 1.0
@export var friction : = 1.0
@export var distance : = 1.0

var velocity = Vector2.ZERO

func _process(delta: float) -> void:
	velocity = velocity.move_toward(direction * speed, acceleration * distance * delta) * friction
	n.position += velocity * delta

func mag(x):
	velocity = direction * Vector2(x, x)
