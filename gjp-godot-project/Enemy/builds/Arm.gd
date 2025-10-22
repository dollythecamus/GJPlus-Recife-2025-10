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

var detection
var picked
var has_detected = false
var picked_item = false

func _ready() -> void:
	$Skeleton.get_modification_stack().enabled = true

func _process(delta: float) -> void:
	c += delta
	
	if has_detected and not picked_item:
		return
	
	if c >= attack_cycle:
		stab()
		c = 0

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
	var direction = n.target.global_position - weapon_hook.global_position
	var d = direction.normalized() * reach
	
	var t = get_tree().create_tween()
	t.tween_property(iktarget, "global_position", p + d, stab_duration/3)
	
	await t.finished
	
	var a = pickup.get_overlapping_areas()
	if a.size() > 0:
		if a[0] is Pickable:
			if not a[0].picked:
				a[0].pick(weapon_hook)
				picked = a[0].get_parent()
				picked_item = true

func _on_detector_area_entered(area: Area2D) -> void:
	#print("bot found item.")
	detection = area
	has_detected = true
	grab(area)

func _on_detector_area_exited(_area: Area2D) -> void:
	has_detected = false
	detection = null
