extends Node2D

@export var player : Node2D
@export var root : Node2D
@export var hint : Node2D
@onready var scene : = get_tree().current_scene

const separator = 60

func spawn_enemy(type, many: int = 1):
	# connect "die" to trigger next
	for i in many:
		var b = Build.builds[type]
		var base = b.split("+")[0]
		var new = load("res://Enemy/bases/" + base + ".tscn").instantiate()
		new.global_position = self.global_position + (Vector2(i,i) * separator)
		new.target = player
		root.call_deferred("add_child", new)
		new.connect("died", scene.enemy_died)
		await new.ready
		var build = new.get_node("Build")
		build.build(b)
		hint.target = new
		hint.show()
	await get_tree().create_timer(1.5).timeout
	hint.hide()

func spawn_object(type):
	var new = Globals.objects[type].instantiate()
	new.global_position = self.global_position
	root.call_deferred("add_child", new)
	await new.ready
	throw_object_towards_player(new)

func spawn_weapon(type):
	var new = Globals.weapons[type].instantiate()
	new.global_position = self.global_position
	root.call_deferred("add_child", new)
	await new.ready
	throw_object_towards_player(new)

func throw_object_towards_player(obj):
	var p = obj.get_node("Pointer")
	var m = obj.get_node("Mover")
	var pp = obj.get_node("Pickable")
	pp.set_process(false)
	# spin , go to the player
	p.rpm = 10
	p.to_point = true
	p.aim = false
	var d = (player.global_position - obj.global_position)
	m.direction = d.normalized()
	m.distance = d.length()
	
	await get_tree().create_timer(1.0).timeout
	pp.set_process(true)
	m.direction = Vector2.ZERO
	m.distance = 1.0
	p.to_point = false
	p.aim = true
	p.rpm = -1
