extends Node2D

func _on_pickable_picked(node) -> void:
	if node is PlayerControls:
		node.add_health(3) # adds 3 health to the player (but the bots can also pick it up, unlikely
		queue_free()
