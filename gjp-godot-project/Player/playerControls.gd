extends Node2D
class_name PlayerControls

@export var move : Mover
@export var roll : Node
@export var pickup : Pickup

func _process(_delta: float) -> void:
	move.direction  = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if Input.is_action_just_pressed("attack"):
		if pickup.picked != null:
			pickup.picked.attack()
