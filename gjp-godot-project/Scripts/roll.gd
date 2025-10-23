extends Node
class_name Roll

# set when upgraded

@onready var n = get_parent()

var hit
var pickup
var visual
var pointer
var move

var roll_visual = preload("res://Player/roll.tscn").instantiate()

var duration = .4
var length = 1000

func _ready() -> void:
	n.add_child(roll_visual)
	roll_visual.hide()

func roll():
	visual.hide()
	roll_visual.show()
	var t = get_tree().create_tween()
	
	t.tween_property(roll_visual, "rotation", 180, duration/3)
	t.chain().tween_property(roll_visual, "rotation", 0, duration/3)
	
	move.mag(1000)
	
	await t.finished
	
	roll_visual.hide()
	visual.show()
