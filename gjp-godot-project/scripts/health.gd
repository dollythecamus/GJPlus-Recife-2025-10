extends Node
class_name Health

@onready var n = get_parent()

signal health_changed(v)

@export var is_player = false

var damage_boost = false

@export var health = 10:
	set(v):
		if health < v:
			health = v
			c = 0
			damage_boost = true
			health_changed.emit(v)
			return
		
		if damage_boost:
			return
		
		if health > v:
			c = 0
			health = v
			damage_boost = true
			health_changed.emit(v)
		
		if health <= 0:
			# add some kind of remnant
			n.die()

var c = 0
func _process(delta):
	c += delta
	if damage_boost and c >= .7:
		damage_boost = false
		c = 0
