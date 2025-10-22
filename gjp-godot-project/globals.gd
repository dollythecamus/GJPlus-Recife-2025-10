extends Node

var builds = {
	"arm": preload("res://Enemy/builds/arm.tscn"),
	"gun": preload("res://Enemy/builds/GUNS.tscn")
}

var objects = {
	"healthpack": preload("res://Objects/healthpack.tscn")
}

var weapons = {
	"pistol": preload("res://Objects/Weapons/pistol.tscn"),
	"melee": preload("res://Objects/Weapons/melee.tscn"),
	"blastgun": preload("res://Objects/Weapons/blastgun.tscn")
}

const progression = [
	"weapon:melee",
	"enemy:ZeroI:1,enemy:ZeroV:1",
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
	"story:beyond is horrifying",
	"enemy:ZeroVI:1",
	"power:healthpack",
	"enemy:ZeroVII:1",
]

const ENEMY = "enemy"
const WEAPON = "weapon"
const POWER = "power"
const STORY = "story"
