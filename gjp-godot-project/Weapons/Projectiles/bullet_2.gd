extends Projectile

func _on_area_entered(area: Area2D) -> void:
	if area is Hit:
		if not (area.get_parent().name == "Player" and is_player):
			area.hit(damage, knockback, mover.direction)
			queue_free()
