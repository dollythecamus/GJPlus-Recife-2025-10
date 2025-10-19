extends Node
class_name Build

@export var root : Bone2D

const builds = {
	"ZeroI": "base1",
	"ZeroII": "base1+arm",
	"ZeroIII": "base2",
	"ZeroIV": "base2+two_arm+two_meelee",
	"ZeroV": "base2+arm+set(mover.speed=300,mover.friction=0.98)",
	"ZeroVI": "base2+arm+gun"
}

# build an arm -> add an arm scene to the root bone

@onready var n = get_parent() 

func build(instruction):
	var s = instruction.split("+")
	# var b = s[0]
	s.remove_at(0)
	
	for i in s:
		if i == "gun":
			build_gun(Vector2(8, -6))
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
	root.add_child(new)
	new.position = offset
	new.pointer.target = n.target
	#new.n = get_parent()

func build_arm(offset):
	var new = Globals.builds["arm"].instantiate()
	root.add_child(new)
	new.position = offset
	new.n = get_parent()
