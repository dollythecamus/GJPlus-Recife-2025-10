extends Node
class_name Health

@onready var n = get_parent()

signal health_changed(v)

@export var is_player = false

@export var health = 10:
	set(v):
		health = v
		health_changed.emit(v)
		if health <= 0:
			# add some kind of remnant
			if is_player:
				pass # game over screen
			else:
				n.queue_free()
