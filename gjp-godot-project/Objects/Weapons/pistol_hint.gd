extends Node

func _on_pickable_picked(n: Variant) -> void:
	if n is PlayerControls:
		n.expect.emit(PlayerControls.Actions.ATTACK)
