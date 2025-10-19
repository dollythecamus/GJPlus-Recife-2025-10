extends Area2D
class_name Pickable

@export var move : Mover
@export var point : Pointer

@onready var n := get_parent()
var target
var picked = false

signal PICKED(n)

func release():
	target = null
	picked = false
	point.to_point = picked

func pick(node):
	target = node
	picked = true
	point.to_point = picked
	PICKED.emit(node)

func _process(_delta: float) -> void:
	move_to_target()

func move_to_target():
	if target == null:
		move.direction = Vector2.ZERO
		move.distance = 0
		return
	
	move.direction = target.global_position - n.global_position
	move.distance = n.global_position.distance_to(target.global_position)
