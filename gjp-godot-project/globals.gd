extends Node

var builds = {
	"arm": preload("res://Enemy/builds/arm.tscn"),
	"gun": preload("res://Enemy/builds/GUNS.tscn")
}

var objects = {
	"healthpack": preload("res://Objects/healthpack.tscn"),
	"upgrade": preload("res://Objects/upgrade.tscn")
}

var weapons = {
	"pistol": preload("res://Objects/Weapons/pistol.tscn"),
	"melee": preload("res://Objects/Weapons/melee.tscn"),
	"blastgun": preload("res://Objects/Weapons/blastgun.tscn")
}

const progression = [
	"weapon:melee",
	"power:upgrade",
	"enemy:ZeroI:1",
	"story:the monsters kill me",
	"enemy:ZeroII:1",
	"power:healthpack",
	"weapon:pistol",
	"enemy:ZeroII:3",
	"story:saw what is beyond life",
	"enemy:ZeroIII:1",
	"weapon:blastgun",
	"power:healthpack",
	"enemy:ZeroIV:1",
	"story:where and when am I?",
	"enemy:ZeroIV:2",
	"enemy:ZeroV:1",
	"power:healthpack",
	"enemy:ZeroVI:1",
	"story:terrorized by the Beyond",
	"enemy:ZeroVI:1",
	"power:healthpack",
	"enemy:ZeroVII:1",
]

const ENEMY = "enemy"
const WEAPON = "weapon"
const POWER = "power"
const STORY = "story"

var other_AIs = []
var all_feet = {}

func start():
	other_AIs = []
	all_feet = {}

func _enter_tree() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func add_script(node, script):
	var new = Node.new()
	new.set_script(load("res://Scripts/" + script))
	node.add_child.call_deferred(new)
	return new
