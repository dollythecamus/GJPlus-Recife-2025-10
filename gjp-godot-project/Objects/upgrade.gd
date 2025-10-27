extends Node2D

@export var upgrade : = ""

func _on_pickable_picked(node) -> void:
	if node is PlayerControls:
		node.upgrade(upgrade) # adds 3 health to the player (but the bots can also pick it up, unlikely
		queue_free()
