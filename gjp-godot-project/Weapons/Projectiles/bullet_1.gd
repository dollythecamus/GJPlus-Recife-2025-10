extends Area2D
class_name Projectile

@export var damage = 3
@onready var mover = $Mover
@export var is_player = false

func _on_area_entered(area: Area2D) -> void:
	if area is Hit:
		if not (area.get_parent().name == "Player" and is_player):
			area.hit(damage, mover.direction)
