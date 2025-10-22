extends Node

@onready var target = get_parent().target
@onready var mover = get_parent().mover
@onready var root = get_parent().get_node("Build").root

static var others = []

const seek_distance = 80
const others_distance = 100

enum STATES {WALK, IDLE, RUN}
var state = STATES.WALK:
	set(v):
		state = v
		state_change.emit(v)

signal state_change(v)

var fire_cycle = .7
var fc = 0

func _init() -> void:
	others.append(self)

func run(delta):
	fc += delta
	
	get_close_avoid()
	balance_others_distances()
	var gun = root.get_node_or_null("Guns")
	if gun != null:
		if fc >= fire_cycle:
			gun.fire()
			fc = 0

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
		
		var distance = i.root.global_position - root.global_position
		var d = distance.length() / others_distance
		
		if d < 1:
			resulting -= distance * .11 * (1/d)
		if d > 1:
			resulting += distance * .11 / d
	
	mover.direction += resulting.normalized() * .5

func _exit_tree() -> void:
	others.erase(self)
