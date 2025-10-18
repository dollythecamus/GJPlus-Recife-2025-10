extends Node
class_name GLOBAL

var builds = {
	"arm": preload("res://Enemy/builds/arm.tscn")
}

const progression = [
	"enemy:ZeroI:1",
	"enemy:ZeroII:1",
	"enemy:ZeroIV:1"
]

const ENEMY = "enemy"
const WEAPON = "weapon"
const POWER = "power"
const STORY = "story"
