extends Node2D

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func _on_picked(n: Variant) -> void:
	if n is PlayerControls:
		show()
