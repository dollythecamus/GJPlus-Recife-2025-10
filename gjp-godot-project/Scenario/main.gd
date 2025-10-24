extends Node 

# Spawner script also triggers story points

var cur = -1
var hoard = 0
var enemy_wave = 0

@export var root : Node2D
@export var player : Node2D
@export var spawner : Node2D
@export var story_label : Label
@export var popup : Control
@export var wave_hint : Node2D
@export var control_hint : Node2D

func _ready() -> void:
	Globals.start()
	
	await get_tree().create_timer(1.0).timeout
	trigger_next()
	control_hint.expect_player(PlayerControls.Actions.MOVEAIM)
	
	popup.get_node("H/continue").connect("pressed", toggle_popup)
	popup.get_node("H/back").connect("pressed", back_to_menu)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_menu"):
		toggle_popup()

func toggle_popup():
	popup.get_node("H/continue").grab_focus.call_deferred()
	@warning_ignore("standalone_ternary")
	popup.show() if not popup.visible else popup.hide()
	get_tree().paused = not get_tree().paused

func back_to_menu():
	Screen.transition()
	await Screen.change
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Visuals/UI/MM/main.tscn")

func trigger_next():
	cur = clamp(cur + 1, 0, Globals.progression.size()-1)
	
	if Globals.progression[cur].begins_with(Globals.ENEMY):
		enemy_wave += 1
		show_wave_hint()
	
	for cmd in Globals.progression[cur].split(","):
		var args = cmd.split(":")
		if args[0] == Globals.ENEMY:
			spawner.spawn_enemy(args[1], int(args[2]))
			hoard += int(args[2])
		elif args[0] == Globals.WEAPON:
			spawner.spawn_weapon(args[1])
			trigger_next()
		elif args[0] == Globals.POWER:
			spawner.spawn_object(args[1], func(n):n.set(args[1], args[2]))
			trigger_next()
		elif args[0] == Globals.STORY:
			story(args[1])
			trigger_next()
		
		await get_tree().create_timer(.5).timeout

func show_wave_hint():
	wave_hint.show()
	wave_hint.roman(enemy_wave)
	await get_tree().create_timer(2.5).timeout
	wave_hint.hide()

func enemy_died():
	hoard -= 1
	if hoard <= 0:
		trigger_next()

func story(t):
	story_label.text = story_label.to_morse(t)
