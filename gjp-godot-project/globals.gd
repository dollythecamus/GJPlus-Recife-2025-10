extends Node

var builds = {
	"arm": preload("res://Enemy/builds/arm.tscn"),
	"gun": preload("res://Enemy/builds/GUNS.tscn")
}

var objects = {
	"health": preload("res://Objects/healthpack.tscn"),
	"upgrade": preload("res://Objects/upgrade.tscn")
}

var weapons = {
	"pistol": preload("res://Objects/Weapons/pistol.tscn"),
	"melee": preload("res://Objects/Weapons/melee.tscn"),
	"blastgun": preload("res://Objects/Weapons/blastgun.tscn"),
	"granade": preload("res://Objects/Weapons/granade.tscn")
}
const progression = [
	"weapon:melee",
	"enemy:ZeroI:1",
	"story:the monsters kill me",
	"enemy:ZeroII:1",
	"power:health:2",
	"enemy:ZeroII:2",
	"story:saw what is beyond life",
	"enemy:ZeroIII:1",
	"enemy:ZeroII:2",
	"weapon:pistol",
	"hint:Attack",
	"power:health:2",
	"enemy:ZeroIV:1",
	"story:where and when am I?",
	"power:upgrade:Roll",
	"hint:Roll",
	"enemy:ZeroIV:2",
	"enemy:ZeroV:1",
	"power:health:2",
	"enemy:ZeroVI:1",
	"weapon:blastgun",
	"story:terrorized by the Beyond",
	"weapon:granade",
	"enemy:ZeroVI:1",
	"power:health:2",
	"enemy:ZeroVII:1",
	"weapon:blastgun",
	"power:upgrade:Defense",
	"hint:Defense",
	"enemy:ZeroIV:1",
	"enemy:ZeroVII:1,enemy:ZeroIV:1",
	"power:health:2",
	"enemy:ZeroV:2",
]

const ENEMY = "enemy"
const WEAPON = "weapon"
const POWER = "power"
const STORY = "story"
const HINT = "hint"

var other_AIs = []
var all_feet = {}

func start():
	other_AIs = []
	all_feet = {}

func _enter_tree() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func add_script(node, script, callable):
	var new = Node.new()
	new.set_script(load("res://Scripts/" + script))
	node.add_child.call_deferred(new)
	callable.call(new)
	return new

func first_child_of_type(node, type):
	for i in node.get_children():
		if i.is_class(type):
			return i
