extends Node
class_name Build

@export var root : Bone2D

const builds = {
	"ZeroI": "base1",
	"ZeroII": "base1+arm",
	"ZeroIII": "base2",
	"ZeroIV": "base2+two_arm+two_meelee"
}

# build an arm -> add an arm scene to the root bone

@onready var n = get_parent() 

func build(instruction):
	var s = instruction.split("+")
	# var b = s[0]
	s.remove_at(0)
	
	for i in s:
		if i == "arm":
			build_arm(Vector2(0, -6))
		elif i == "two_arm":
			build_arm(Vector2(8, -6))
			build_arm(Vector2(-8, -6))

func build_arm(offset):
	var new = Globals.builds["arm"].instantiate()
	root.add_child(new)
	new.position = offset
	new.n = get_parent()
