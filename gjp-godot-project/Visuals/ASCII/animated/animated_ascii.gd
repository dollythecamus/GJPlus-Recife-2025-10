@tool
extends Node2D

@onready var frames = get_children()
@export var looping = false
@export var auto_start = false

var fpf = 6
var f = 0

var i = 0

signal finished 

func _ready() -> void:
	set_process(auto_start)

func play():
	i = 0
	f = 0
	set_process(true)

func stop():
	finished.emit()
	set_process(false)

func next_frame():
	get_node("frame" + str(i)).hide()
	i += 1
	get_node("frame" + str(i)).show()

func _process(_delta: float) -> void:
	f += 1
	if f >= fpf:
		
		if looping and i >= get_child_count() - 1:
			i = 0
		if not looping:
			stop()
		
		next_frame()
		
		f = 0
