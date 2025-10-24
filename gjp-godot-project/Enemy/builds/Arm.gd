extends Node
class_name Arm

var n 

@onready var iktarget = $ArmT0
@onready var iktargetrest = $ArmRest

@export var weapon_hook : Node2D
@export var pickup : Pickup

@export var reach := 100
@export var stab_duration = .6

var attack_cycle = stab_duration * 1.5
var c = 0

var release_cycle = 9.0
var rc = randf()/release_cycle

var detection
var has_detected = false

var prepare_throw = false

func _ready() -> void:
	$Skeleton.get_modification_stack().enabled = true

func _process(delta: float) -> void:
	c += delta
	rc += delta
	
	if has_detected and not pickup.did_pick:
		return
	
	if n.target == null:
		return
	
	if pickup.node_picked != null:
		if rc >= release_cycle:
			n.AI.do_melee_mode()
			pickup.release()
			rc = 0
	
	if c >= attack_cycle:
		if pickup.node_picked != null:
			var a = pickup.node_picked.get_node_or_null("Attack") 
			if a == null:
				pickup.release()
			else:
				if a is Shooter:
					n.AI.do_ranged_mode()
					iktarget.position = iktargetrest.position
				elif a is Throwable:
					n.AI.do_ranged_mode()
					a.target.aim_at(n.target)
					stab()
					if not prepare_throw:
						prepare_throw = true
						c = 0
						return 
				else:
					n.AI.do_melee_mode()
					stab()
				
				a.attack()
				if prepare_throw:
					prepare_throw = false
					n.AI.do_melee_mode()
		else:
			stab()
		c = 0

func _exit_tree() -> void:
	pickup.release()

func stab():
	var p = iktarget.global_position
	var direction = n.target.global_position - weapon_hook.global_position
	var d = direction.normalized() * reach
	
	var t = get_tree().create_tween()
	t.tween_property(iktarget, "global_position", p + d, stab_duration/4)
	t.chain().tween_property(iktarget, "global_position", iktargetrest.global_position, stab_duration / 4 * 3)
	
	await t.finished

func grab(target):
	var p = iktarget.global_position
	var direction = target.global_position - weapon_hook.global_position
	var d = direction.normalized() * reach
	
	var t = get_tree().create_tween()
	t.tween_property(iktarget, "global_position", p + d, stab_duration*2.0)
	
	await t.finished
	
	pickup.pick_first(n)

func _on_detector_area_entered(area: Area2D) -> void:
	#print("bot found item.")
	if not pickup.did_pick:
	# some randomness of whether or not the bot wants to pick up the thing or not
		if randf() < .5:
			return
		
		detection = area
		has_detected = true
		grab(area)

func _on_detector_area_exited(_area: Area2D) -> void:
	has_detected = false
	detection = null
