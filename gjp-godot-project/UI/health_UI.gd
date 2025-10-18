extends HBoxContainer

@export var player_health : Health

var clock = 0

func _ready() -> void:
	update()

func update():
	var c = get_children()
	var diff = int(round(player_health.health) - c.size())
	
	if diff == 0:
		return
	
	if diff < 0:
		for i in abs(diff):
			get_children()[0].queue_free()
	
	elif diff > 0:
		for i in abs(diff):
			var new = get_children()[0].duplicate()
			add_child(new)

func _process(delta: float) -> void:
	clock += delta
	
	var c = get_children()
	var j = 0
	for i in c:
		i.get_child(0).position.y += sin((clock + j) * 10) * .1
		j += 1


func _on_player_hit() -> void:
	update()
