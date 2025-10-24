extends Area2D
class_name Pickup

@onready var n := get_parent()

var picked = null
@export var is_player = false

func release(other = false):
	if picked != null:
		if not other:
			picked.get_node("Pickable").release()
		picked.get_node("Pickable").disconnect("released", _on_released)
		picked = null

func _process(_delta: float) -> void:
	if not is_player:
		return
	
	if Input.is_action_just_pressed("pick"):
		var a = get_overlapping_areas()
		if a.size() > 0:
			if a[0] is Pickable:
				if not a[0].picked:
					a[0].pick(n)
					a[0].owns(n)
					a[0].connect("released", _on_released)
					picked = a[0].get_parent()
				else:
					release()

func _on_released():
	release(true)
