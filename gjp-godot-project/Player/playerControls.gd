extends Node2D
class_name PlayerControls

@export var move : Mover
@export var roll : Node
@export var pickup : Pickup

var c = 0

var dead = false

signal update_health

func die():
	if dead:
		return
	dead = true
	pickup.release()
	# do some death vfx !
	$visual.hide()
	move.disable()
	await get_tree().create_timer(2.0).timeout
	reborn()

func reborn():
	# vfx!!! 
	move.enable()
	$visual.show()
	$Health.health = 3
	global_position = Vector2(randf_range(-10, 600), randf_range(-10, 600))
	dead = false

func _process(delta: float) -> void:
	move.direction  = Input.get_vector("move_left","move_right","move_up","move_down")
	
	global_position.x = clamp(global_position.x, 20, 600)
	global_position.y = clamp(global_position.y, 10, 400)

	c += delta
	
	if not move.direction.is_zero_approx():
		$visual.rotation = sin(c * 10) * .2
	
	if Input.is_action_just_pressed("attack"):
		if pickup.picked != null:
			var attacking = pickup.picked.get_node("Attack")
			if attacking != null:
				attacking.attack(true)
			#var attack = pickup.picked.get_node("Attack")
			#if attack != null:
			#	pass # TODO

signal HIT
func _on_hit() -> void:
	HIT.emit()

func add_health(i):
	$Health.health += i
	update_health.emit()
