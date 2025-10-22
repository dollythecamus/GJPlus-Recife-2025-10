extends Area2D
class_name Hurt

@export var mover : Mover
@export var damage := 1
@export var knockback := 90

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Hit:
		var d = Vector2.ZERO
		if mover != null:
			d = mover.global_velocity.normalized()
		area.hit(damage, knockback, d)
