extends Node2D

@export var mover : Mover
@export var target : Node2D

const seek_distance = 90

enum STATES {WALK, IDLE, RUN}
var state = STATES.WALK:
	set(v):
		state = v
		state_change.emit(v)

signal state_change(v)

func _process(delta: float) -> void:
	var d = target.global_position - mover.n.global_position
	if d.length() > seek_distance:
		mover.direction = d.normalized()
		state = STATES.WALK
	else:
		mover.direction = Vector2.ZERO
		state = STATES.IDLE
