extends Node2D

@export var mover : Mover
@export var target : Node2D
@onready var AI = $AI

const seek_distance = 130

enum STATES {WALK, IDLE, RUN}
var state = STATES.WALK:
	set(v):
		state = v
		state_change.emit(v)

signal state_change(v)
signal died

func _process(delta: float) -> void:
	var d = target.global_position - mover.n.global_position
	if d.length() > seek_distance:
		mover.direction = d.normalized()
		state = STATES.WALK
	else:
		mover.direction = Vector2.ZERO
		state = STATES.IDLE

func _exit_tree() -> void:
	died.emit()
