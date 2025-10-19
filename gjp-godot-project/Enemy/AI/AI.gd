extends Node

@onready var target = get_parent().target
@onready var mover = get_parent().mover

static var others = []

const seek_distance = 80
const others_distance = 100

enum STATES {WALK, IDLE, RUN}
var state = STATES.WALK:
	set(v):
		state = v
		state_change.emit(v)

signal state_change(v)

func _init() -> void:
	others.append(self)

func run():
	get_close_avoid()
	balance_others_distances()

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

func balance_others_distances():
	if target == null:
		return
	
	var resulting = Vector2.ZERO
	
	for i in others:
		if i == self:
			continue
		
		var distance = i.global_position - self.global_position
		
	

func _exit_tree() -> void:
	others.erase(self)
