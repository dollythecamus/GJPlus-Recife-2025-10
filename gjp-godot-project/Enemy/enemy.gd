extends Node2D

@export var mover : Mover
@export var target : Node2D
@onready var AI = $AI
@onready var build = $Build
@onready var health = $Health

func _ready() -> void:
	$Skeleton2D/root/Pointer.target = target

signal died

func _process(delta: float) -> void:
	AI.run(delta)

func _exit_tree() -> void:
	died.emit()

func die():
	# vfx here
	queue_free()
