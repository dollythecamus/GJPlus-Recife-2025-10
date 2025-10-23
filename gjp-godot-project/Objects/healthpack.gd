extends Node2D

var health = 2:
	set(v):
		health = v
		if v is String:
			health = int(v)

func _on_pickable_picked(node) -> void:
	if node is PlayerControls:
		node.add_health(health) # adds 3 health to the player (but the bots can also pick it up, unlikely
		queue_free()
