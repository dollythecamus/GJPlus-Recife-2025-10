extends Node2D

@export var player : Node2D
@export var root : Node2D
@export var hint : Node2D
@onready var scene : = get_tree().current_scene

func spawn_enemy(type, many: int = 1):
	# connect "die" to trigger next
	for i in many:
		var b = Build.builds[type]
		var base = b.split("+")[0]
		var new = load("res://Enemy/bases/" + base + ".tscn").instantiate()
		new.global_position = self.global_position + Vector2(i * 30, i * 30)
		new.target = player
		root.call_deferred("add_child", new)
		new.connect("died", scene.trigger_next)
		await new.ready
		var build = new.get_node("Build")
		build.build(b)
		hint.target = new
		hint.show()
	await get_tree().create_timer(1.5).timeout
	hint.hide()
