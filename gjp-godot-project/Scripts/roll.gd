extends Node
class_name Roll

# set when upgraded

@onready var n = get_parent()

var hit
var pickup
var visual
var pointer
var move
var health

var roll_visual = preload("res://Player/roll.tscn").instantiate()

var duration = .4
var length = 1000

var rate = Rate.new()

func _ready() -> void:
	n.add_child(rate)
	n.add_child(roll_visual)
	roll_visual.hide()

func roll():
	if rate.waiting:
		return
	
	visual.hide()
	roll_visual.show()
	
	rate.start(duration * 1.1)
	move.mag(length)
	health.invul(duration*1.3)
	
	await rate.done
	
	roll_visual.hide()
	visual.show()
