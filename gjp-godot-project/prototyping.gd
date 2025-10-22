extends Node2D

@onready var root = self
@onready var player = $Player
const separator = 60 

func _ready() -> void:
	pass

func spawn_enemy(type, many: int = 1):
	for i in many:
		var b = Build.builds[type]
		var base = b.split("+")[0]
		var new = load("res://Enemy/bases/" + base + ".tscn").instantiate()
		new.global_position = self.global_position + (Vector2(i,i) * separator)
		new.target = player
		root.add_child(new)
		var build = new.get_node("Build")
		build.build(b)
