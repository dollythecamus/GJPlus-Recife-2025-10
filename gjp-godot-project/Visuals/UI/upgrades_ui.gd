extends HBoxContainer

func show_upgrade(which):
	get_node(which).show()

# ui bobble (could be a separate script because of reuse
var clock = 0.0
func _process(delta: float) -> void:
	clock += delta
	
	var c = get_children()
	var j = 0
	for i in c:
		i.get_child(0).position.y += sin((clock + j) * 10) * .1
		j += 1
