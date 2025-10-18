extends Node2D
class_name Pointer

@export var rotate_parent = false
@onready var n = get_parent() if rotate_parent else self

@export var to_point = false
@export var aim = false
@export var flips_at_half = false
@export var target : Node2D
@export var mover_inertia : Mover
@export var rpm = -1
@export var angle_offset := PI/2

var clock = 0

var last = Vector2.ZERO
var vec = Vector2.ZERO

func _process(delta: float) -> void:
	# the pickup area circles the parent node (player) in the direction of the mouse
	if not to_point:
		return
	
	if target != null:
		point_to_target()
	
	elif aim:
		point_to_aim()
	
	elif rpm != -1:
		spin(delta)
	
	elif mover_inertia != null:
		point_to(n, mover_inertia.direction.angle())
	
	if (n.rotation_degrees > 90 || n.rotation_degrees < -90) and flips_at_half:
		n.scale.y = -1
	else:
		n.scale.y = 1
	
	#else:
	#	point_to(self, (get_global_mouse_position() - n.global_position).angle())

func point_to_aim():
	vec = Input.get_vector("point_left","point_right","point_up", "point_down")
	
	if vec.length() > 0:
		point_to(n, vec.angle())

func point_to_target():
	point_to(n, (target.global_position - n.global_position).angle() + angle_offset)

func point_to(node, angle):
	node.rotation = angle

func spin(delta):
	clock += delta * rpm
	point_to(n, sin(clock) * 4)
