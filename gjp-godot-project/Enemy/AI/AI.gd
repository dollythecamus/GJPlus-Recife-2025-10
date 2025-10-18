extends Node

@onready var target = get_parent().target
@onready var mover = get_parent().mover

const seek_distance = 90

enum STATES {WALK, IDLE, RUN}
var state = STATES.WALK:
	set(v):
		state = v
		state_change.emit(v)

signal state_change(v)

func run():
	get_close_avoid()

func get_close_avoid():
	if target == null:
		return
	var d = target.global_position - mover.n.global_position
	if d.length() > seek_distance:
		mover.direction = d.normalized()
		state = STATES.WALK
	else:
		mover.direction = Vector2.ZERO
		state = STATES.IDLE
