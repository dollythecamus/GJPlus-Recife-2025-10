extends Node 

# Spawner script also triggers story points

var cur = 0

@export var root : Node2D
@export var player : Node2D

@export var spawner : Node2D

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	trigger_next()

func trigger_next():
	var cmd = GLOBAL.progression[cur]
	var args = cmd.split(":")
	if args[0] == GLOBAL.ENEMY:
		spawner.spawn_enemy(args[1], int(args[2]))
	elif args[0] == GLOBAL.WEAPON:
		print("spawn a new weapon")
		trigger_next()
	elif args[0] == GLOBAL.POWER:
		print("spawn a new power")
		trigger_next()
	elif args[0] == GLOBAL.STORY:
		print("write some story")
		trigger_next()
	
	cur = clamp(cur + 1, 0, GLOBAL.progression.size()-1)
