extends Node2D
class_name EnemyAI

@export var mover : Mover
@export var pointer : Pointer
@export var target : Node2D
@onready var AI = $AI
@onready var build = $Build
@onready var health = $Health

var feet = []
signal died

func _ready() -> void:
	get_feet()
	$Skeleton2D.get_modification_stack().enabled = true
	pointer.target = target

func get_feet():
	for i in get_children():
		if i is FootIKTarget:
			feet.append(i)

func _process(delta: float) -> void:
	AI.run(delta)

func _exit_tree() -> void:
	feet[0].remove(self)
	died.emit()

func die():
	# vfx here
	queue_free()

func _on_ai_state_change(v: Variant) -> void:
	for i in feet:
		i.state = v
