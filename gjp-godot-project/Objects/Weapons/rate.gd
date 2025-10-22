extends Node2D
class_name Rate

@export var clock_display : DISPLAY

enum DISPLAY {dashed}

signal done
var waiting

var c = 0
var duration = 0

func start(rate):
	waiting = true
	show()
	set_process(true)
	duration = rate
	await get_tree().create_timer(rate).timeout
	done.emit()
	waiting = false
	hide()
	set_process(false)

func _process(delta: float) -> void:
	c += delta
	# queue_redraw()

func _draw() -> void:
	var dashes = int(duration * 6)
	
	for i in dashes:
		draw_dashed_line(Vector2.ZERO, Vector2.UP, Color.WHITE)
	
