extends Node2D

@export var settled_place_node : Node2D
@export_range(-1, 1, 1) var preference : float

static var all_feet = {}

enum STATES {WALK, IDLE, RUN}
var state = STATES.WALK

const settle_threshold = 10

const step_threshold = 45
const step_distance = 95
const step_duration = .105

var settled = true
var is_stepping = false

@onready var settled_place : = settled_place_node.global_position

@onready var n = get_parent()

func _ready() -> void:
	if all_feet.has(n):
		all_feet[n].append(self)
	else:
		all_feet[n] = []

func _process(delta: float) -> void:
	settled_place = settled_place_node.global_position
	
	match state:
		STATES.WALK:
			solve_walk()
		STATES.IDLE:
			solve_idle()

func solve_walk():
	var distance = settled_place - self.global_position
	
	if settled and ! is_stepping and none_stepping():
		if distance.length() > step_threshold:
			_step()

func solve_idle():
	var distance = settled_place - self.global_position
	# preference to which side it's on
	distance.x += preference * settle_threshold
	
	if settled and distance.length() > settle_threshold:
		settled = false
		settle()

func _on_set_state(v):
	state = v

func settle():
	var t = get_tree().create_tween() 
	
	var p = self.global_position
	var direction = settled_place - self.global_position
	
	t.tween_property(self, "global_position", p + direction, step_duration)
	
	await t.finished
	settled = true

func _step():
	settled = false
	is_stepping = true
	
	var t = get_tree().create_tween() 
	
	var p = self.global_position
	var direction = (settled_place - self.global_position)
	
	var step = direction * 1.6
	
	t.tween_property(self, "global_position", p + step + Vector2(0, -90), step_duration)
	t.chain().tween_property(self, "global_position", p + step, step_duration)
	
	await t.finished
	is_stepping = false
	settled = true

func none_stepping():
	return not all_feet[n].any(_is_stepping)

func _is_stepping(other):
	return other.is_stepping

func pos(x):
	if x < 0:
		return -1
	else:
		return 1

func _on_state_change(v: Variant) -> void:
	state = v
