extends Area2D
class_name Pickable

@export var move : Mover
@export var point : Pointer
@export var hurt : Hurt

@onready var n := get_parent()
var target
var picked = false

signal PICKED(n)

const enemy_is_owner = 8
const player_is_owner = 16

func release():
	target = null
	picked = false
	point.to_point = picked
	if hurt != null:
		hurt.collision_mask = 0 # hurt nobode

func pick(node):
	target = node
	picked = true
	point.to_point = picked
	PICKED.emit(node)

func owns(_n):
	if _n is PlayerControls:
		if hurt != null:
			hurt.collision_mask = player_is_owner # to hurt bots only
		point.aim = true
		point.target = null
	elif _n is EnemyAI:
		if hurt != null:
			hurt.collision_mask = enemy_is_owner # to hurt players only
		point.target = _n.target

func _process(_delta: float) -> void:
	move_to_target()

func move_to_target():
	if target == null:
		move.direction = Vector2.ZERO
		move.distance = 0
		return
	
	move.direction = target.global_position - n.global_position
	move.distance = n.global_position.distance_to(target.global_position)
