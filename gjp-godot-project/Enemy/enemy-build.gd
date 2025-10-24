extends Node
class_name Build

@export var root : Bone2D

@export var build_ready = ""

const builds = {
	"ZeroI": "base1",
	"ZeroII": "base1+arm",
	"ZeroIII": "base2",
	"ZeroIV": "base2+two_arm+two_meelee",
	"ZeroV": "base2+arm+set(mover.speed=300,mover.friction=0.98)",
	"ZeroVI": "base2+arm+gun",
	"ZeroVII": "base1+two_gun+set(mover.speed=150,health.health=15)"
}

# build an arm -> add an arm scene to the root bone

@onready var n = get_parent() 

func _ready() -> void:
	await n.ready
	if build_ready != "":
		build_model(build_ready)

func build_model(model):
	build(builds[model])

func build(instruction):
	var s = instruction.split("+")
	# var b = s[0]
	s.remove_at(0)
	
	for i in s:
		if i == "gun":
			build_gun(Vector2(8, -6))
		elif i == "two_gun":
			build_gun(Vector2(8, -6))
			build_gun(Vector2(-8, -6))
		elif i == "arm":
			build_arm(Vector2(0, -6))
		elif i == "two_arm":
			build_arm(Vector2(8, -6))
			build_arm(Vector2(-8, -6))
		elif i.begins_with("set("):
			var j = i.trim_suffix(")").trim_prefix("set(")
			var js = j.split(",")
			for k in js:
				var w = k.split("=")
				var value = w[1]
				var vs = w[0].split(".")
				# magic at work, folks
				n.get(vs[0]).set(vs[1], float(value))

func build_gun(offset):
	var new = Globals.builds["gun"].instantiate()
	new.position = offset
	new.mover = n.mover
	new.n = get_parent()
	root.add_child(new)
	new.pointer.target = n.target

func build_arm(offset):
	var new = Globals.builds["arm"].instantiate()
	new.position = offset
	new.n = get_parent()
	root.add_child(new)
