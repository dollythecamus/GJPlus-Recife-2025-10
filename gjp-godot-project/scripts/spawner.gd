extends Node2D

# Spawner script also triggers story points

var cur = 0

@export var root : Node2D
@export var player : Node2D

func _ready() -> void:
	trigger_next()

func trigger_next():
	var cmd = GLOBAL.progression[cur]
	var args = cmd.split(":")
	if args[0] == GLOBAL.ENEMY:
		spawn_enemy(args[1], int(args[2]))
	elif args[0] == GLOBAL.WEAPON:
		pass
	elif args[0] == GLOBAL.POWER:
		pass
	elif args[0] == GLOBAL.STORY:
		pass
	
	cur += 1

func spawn_enemy(type, many: int = 1):
	# connect "die" to trigger next
	for i in many:
		var new = load("res://Enemy/types/enemy" + type + ".tscn").instantiate()
		new.global_position = self.global_position
		new.target = player
		root.add_child(new)
	
