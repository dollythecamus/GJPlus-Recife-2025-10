extends Node
class_name GLOBAL

var builds = {
	"arm": preload("res://Enemy/builds/arm.tscn"),
	"gun": preload("res://Enemy/builds/GUNS.tscn")
}

var objects = {
	"healthpack": preload("res://Objects/healthpack.tscn")
}

var weapons = {
	"pistol": preload("res://Weapons/pistol.tscn"),
	"melee": preload("res://Weapons/melee.tscn"),
	"blastgun": preload("res://Weapons/blastgun.tscn")
}

const progression = [
	"weapon:blastgun",
	"weapon:melee",
	"enemy:ZeroVI:1",
	"story:year 34x2 AL",
	"power:healthpack",
	"weapon:pistol",
	"enemy:ZeroIV:1",
	"enemy:ZeroV:1"
]

const ENEMY = "enemy"
const WEAPON = "weapon"
const POWER = "power"
const STORY = "story"
