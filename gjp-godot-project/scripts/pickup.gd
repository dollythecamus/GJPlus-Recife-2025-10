extends Area2D
class_name Pickup

@onready var n := get_parent()

var picked = null

func release():
	if picked != null:
		picked.get_node("Pickable").release()
		picked = null

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pick"):
		var a = get_overlapping_areas()
		if a.size() > 0:
			if a[0] is Pickable:
				if not a[0].picked:
					a[0].pick(n)
					picked = a[0].get_parent()
				else:
					a[0].release()
					picked = null
