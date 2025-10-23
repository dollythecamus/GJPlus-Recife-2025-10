extends Node
class_name Defense

# set when upgraded

@onready var n = get_parent()

var move
var p_hit

var defense = preload("res://Player/defense.tscn").instantiate()

var duration = 5.0
var defending = false

var rate = Rate.new()
var health = defense.get_node("Health")
var hit = defense.get_node("Hit")
var c = hit.get_node("Col")

func _ready() -> void:
	health.n = self
	
	n.add_child(rate)
	n.add_child(defense)
	defense.hide()
	rate.connect("done", _on_rate_done)

func defend():
	if rate.waiting:
		stop()
		return
	
	move.disable()
	p_hit.disable()
	defense.show()
	
	rate.start(duration * 3.0)

func stop():
	rate.interrupt()
	defense.hide()
	move.enable()
	p_hit.enable()

func die():
	stop()

func _on_rate_done():
	defense.hide()
	move.enable()
