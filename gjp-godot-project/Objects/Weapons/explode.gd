extends Node

@export var effect : AnimatedASCII
@export var hurt : Hurt
@export var rate : Rate
@export var visual : Node2D

@onready var n = get_parent()

func explode():
	rate.start(.5)
	
	await rate.done
	
	visual.hide()
	effect.show()
	effect.play()
	hurt.hit_all_area()
	
	await effect.finished
	n.queue_free()
