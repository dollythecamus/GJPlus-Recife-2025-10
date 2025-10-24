extends Node

@export var pointer : Pointer
@export var mover : Mover

@onready var n := get_parent()

@export var reach := 60

func attack():
	var dir = Vector2.from_angle(pointer.rotation)
	mover.velocity += dir * reach
	
	$AudioStreamPlayer.play()
	# the hit should be enough
