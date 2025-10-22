extends Node 

# Spawner script also triggers story points

var cur = -1
var hoard = -1

@export var root : Node2D
@export var player : Node2D
@export var spawner : Node2D
@export var story_label : Label
@export var popup : Control

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	trigger_next()

func trigger_next():
	cur = clamp(cur + 1, 0, Globals.progression.size()-1)
	
	for cmd in Globals.progression[cur].split(","):
		var args = cmd.split(":")
		if args[0] == Globals.ENEMY:
			spawner.spawn_enemy(args[1], int(args[2]))
			hoard += int(args[2])
		elif args[0] == Globals.WEAPON:
			spawner.spawn_weapon(args[1])
			trigger_next()
		elif args[0] == Globals.POWER:
			spawner.spawn_object(args[1])
			trigger_next()
		elif args[0] == Globals.STORY:
			story(args[1])
			trigger_next()

		await get_tree().create_timer(.5).timeout

func enemy_died():
	hoard -= 1
	if hoard <= 0:
		trigger_next()

func story(t):
	story_label.text = story_label.to_morse(t)
