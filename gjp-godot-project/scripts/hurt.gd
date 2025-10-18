extends Area2D
class_name Hurt

@export var mover : Mover
@export var damage := 1

func _on_area_entered(area: Area2D) -> void:
	if area is Hit:
		area.hit(damage, mover.direction)
