extends Node2D
class_name FootIKTarget

@export var settled_place_node : Node2D
@export_range(-1, 1, 1) var preference : float

@onready var settled_place : = settled_place_node.global_position
@onready var n = get_parent()

static var all_feet = {}

enum STATES {WALK, IDLE, RUN}
var state = STATES.WALK

const settle_threshold = 5

const step_threshold = 35
var step_duration = .25

var settled = true
var is_stepping = false


func _ready() -> void:
	if all_feet.has(n):
		all_feet[n].append(self)
	else:
		all_feet[n] = []

func _process(_delta: float) -> void:
	settled_place = settled_place_node.global_position
	
	match state:
		STATES.WALK:
			solve_walk()
		STATES.IDLE:
			solve_idle()

func solve_walk():
	var distance = settled_place - self.global_position
	
	if settled and ! is_stepping and any_2_stepping():
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
	
	var step = direction * 1.65
	var side = direction.rotated((PI/2) * preference) / 3
	
	t.tween_property(self, "global_position", p + step + side, step_duration/2)
	t.chain().tween_property(self, "global_position", p + step, step_duration)
	
	await t.finished
	is_stepping = false
	settled = true

func any_2_stepping():
	return not all_feet[n].all(_is_stepping)

func _is_stepping(other):
	return other.is_stepping

func pos(x):
	if x < 0:
		return -1
	else:
		return 1

func _on_state_change(v: Variant) -> void:
	state = v

func remove(x):
	all_feet.erase(x)
