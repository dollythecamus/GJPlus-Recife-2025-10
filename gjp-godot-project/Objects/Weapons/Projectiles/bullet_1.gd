extends Area2D
class_name Projectile

@export var damage = 3
@export var knockback = 200
@onready var mover = $Mover
@onready var anim = $AnimatedASCII 
@export var is_player = false

const hit_enemy = 16
const hit_player = 8

func owns(_n):
	if _n is PlayerControls:
		collision_mask = hit_enemy # to hurt bots only
	elif _n is EnemyAI:
		collision_mask = hit_player # to hurt players only
	else:
		breakpoint

func _on_area_entered(area: Area2D) -> void:
	if area is Hit:
		if not (area.get_parent().name == "Player" and is_player):
			area.hit(damage, knockback, mover.direction)
			$ASCII.hide()
			anim.play()
			$Col.set_deferred("disabled", true)
			await anim.finished
			queue_free()
