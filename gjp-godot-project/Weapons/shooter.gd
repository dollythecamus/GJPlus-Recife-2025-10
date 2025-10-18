extends Node

@export var projectile : PackedScene
@export var p : Pointer

@onready var n := get_parent()

func fire():
	var new = projectile.instantiate()
	var m = new.get_node("Mover")
	m.direction = p.vec.normalized() if not p.vec.is_zero_approx() else Vector2.from_angle(p.rotation)
	m.mag(1000)
	new.global_position = n.global_position
	get_tree().current_scene.add_child(new)
