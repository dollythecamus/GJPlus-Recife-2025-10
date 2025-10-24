extends Node
class_name BotAI

@onready var target = get_parent().target
@onready var mover = get_parent().mover
@onready var root = get_parent().get_node("Build").root


var seek_distance = 80.0
var seek_distance_close = 2.0
var others_distance = 100.0

enum STATES {WALK, IDLE, RUN}
var state = STATES.WALK:
	set(v):
		state = v
		state_change.emit(v)

enum MODES {MELEE, RANGED}
var mode = MODES.MELEE

signal state_change(v)

var fire_cycle = .7
var fc = randf()/fire_cycle

func _init() -> void:
	Globals.other_AIs.append(self)

func run(delta):
	fc += delta
	
	get_close_avoid()
	balance_others_distances()
	get_guns().all(func(x): x.run(delta))

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
		if d.length() < seek_distance / seek_distance_close:
			mover.direction = -d.normalized()
			state = STATES.WALK

func balance_others_distances():
	if target == null:
		return
	
	var resulting = Vector2.ZERO
	
	for i in Globals.other_AIs:
		if i == self:
			continue
		
		var distance = i.root.global_position - root.global_position
		var d = distance.length() / others_distance
		
		if d < 1:
			resulting -= distance * .11 * (1/d)
		if d > 1:
			resulting += distance * .11 / d
	
	mover.direction += resulting.normalized() * .5

func get_guns():
	var r = []
	for i in root.get_children():
		if i is BotGun:
			r.append(i)
	if r.size() > 0 && mode != MODES.MELEE:
		do_ranged_mode()
	return r

func do_ranged_mode():
	seek_distance = 300
	seek_distance_close = 1.35
	others_distance = 150
	mode = MODES.RANGED

func do_melee_mode():
	seek_distance = 70
	seek_distance_close = 2.0
	others_distance = 80
	mode = MODES.MELEE

func _exit_tree() -> void:
	Globals.other_AIs.erase(self)
