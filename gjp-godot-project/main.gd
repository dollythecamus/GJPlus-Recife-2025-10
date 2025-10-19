extends Node 

# Spawner script also triggers story points

var cur = -1
var hoard = -1

@export var root : Node2D
@export var player : Node2D
@export var spawner : Node2D
@export var story_label : Label
@export var popup : Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("back"):
		popup.popup()

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	trigger_next()

func trigger_next():
	cur = clamp(cur + 1, 0, GLOBAL.progression.size()-1)
	
	var cmd = GLOBAL.progression[cur]
	var args = cmd.split(":")
	if args[0] == GLOBAL.ENEMY:
		spawner.spawn_enemy(args[1], int(args[2]))
		hoard = int(args[2])
	elif args[0] == GLOBAL.WEAPON:
		spawner.spawn_weapon(args[1])
		trigger_next()
	elif args[0] == GLOBAL.POWER:
		spawner.spawn_object(args[1])
		trigger_next()
	elif args[0] == GLOBAL.STORY:
		story(args[1])
		trigger_next()

func enemy_died():
	hoard -= 1
	if hoard <= 0:
		trigger_next()

func story(t):
	story_label.text = story_label.to_morse(t)
