extends Node

var n 

@onready var iktarget = $ArmT0
@onready var iktargetrest = $ArmRest

@export var weapon_hook : Node2D
@export var pickup : Pickup

@export var reach := 100
@export var stab_duration = .6

var attack_cycle = stab_duration * 2
var c = 0

func _ready() -> void:
	$Skeleton.get_modification_stack().enabled = true

func _process(delta: float) -> void:
	c += delta
	
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
	
