extends Node2D
class_name PlayerControls

@export var move : Mover
@export var roll : Node
@export var pickup : Pickup

var c = 0

func _process(delta: float) -> void:
	move.direction  = Input.get_vector("move_left","move_right","move_up","move_down")
	
	c += delta
	
	if not move.direction.is_zero_approx():
		$visual.rotation = sin(c * 10) * .2
	
	if Input.is_action_just_pressed("attack"):
		if pickup.picked != null:
			var shooter = pickup.picked.get_node("Shooter")
			if shooter != null:
				shooter.fire(true)
			#var attack = pickup.picked.get_node("Attack")
			#if attack != null:
			#	pass # TODO

signal HIT
func _on_hit() -> void:
	HIT.emit()
