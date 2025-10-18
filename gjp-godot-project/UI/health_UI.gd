extends HBoxContainer

@export var player_health : Health

var clock = 0

func update(health):
	var c = get_children()
	var diff = int(round(health) - c.size())
	
	if diff == 0:
		return
	
	if diff < 0:
		return
	
	elif diff > 0:
		pass

func _process(delta: float) -> void:
	clock += delta
	
	var c = get_children()
	var j = 0
	for i in c:
		i.get_child(0).position.y += sin((clock + j) * 10) * .1
		j += 1
