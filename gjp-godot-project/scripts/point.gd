extends Node2D
class_name Pointer

@onready var n = get_parent()
@export var to_point = false
@export var aim = false
@export var target : Node2D

var last = Vector2.ZERO
var vec = Vector2.ZERO

func _process(_delta: float) -> void:
	# the pickup area circles the parent node (player) in the direction of the mouse
	if not to_point:
		return
	
	if target != null:
		point_to_target()
	
	elif aim:
		point_to_aim()
	#else:
	#	point_to(self, (get_global_mouse_position() - n.global_position).angle())

func point_to_aim():
	vec = Input.get_vector("point_left","point_right","point_up", "point_down")
	
	if vec.length() > 0:
		point_to(self, vec.angle())

func point_to_target():
	point_to(n, (target.global_position - n.global_position).angle() + PI/2)

func point_to(node, angle):
	node.rotation = angle
