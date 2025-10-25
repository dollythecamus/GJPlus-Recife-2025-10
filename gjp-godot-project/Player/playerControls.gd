extends Node2D
class_name PlayerControls

@export var move : Mover
@export var pickup : Pickup

var upgrades = {}

var c = 0
var dead = false

signal update_health
signal upgraded(which)
signal hit

signal act(what)
signal expect(what)

enum Actions {GRAB, ROLL, DEFEND, MOVEAIM, ATTACK, max}

func die():
	if dead:
		return
	dead = true
	pickup.release()
	# do some death vfx !
	$visual.hide()
	move.disable()
	await get_tree().create_timer(2.0).timeout
	reborn()

func reborn():
	# vfx!!! 
	$AudioStreamPlayer.play()
	move.enable()
	$visual.show()
	$Health.health = 3
	global_position = Vector2(randf_range(-10, 600), randf_range(-10, 600))
	dead = false
	update_health.emit()

func _process(delta: float) -> void:
	move.direction  = Input.get_vector("move_left","move_right","move_up","move_down")
	
	global_position.x = clamp(global_position.x, 20, 600)
	global_position.y = clamp(global_position.y, 10, 400)

	c += delta
	
	if not move.direction.is_zero_approx():
		$visual.rotation = sin(c * 10) * .2
		act.emit(Actions.MOVEAIM)
	
	if Input.is_action_just_pressed("attack"):
		if pickup.did_pick:
			var attacking = pickup.node_picked.get_node("Attack")
			if attacking != null:
				attacking.attack()
				act.emit(Actions.ATTACK)
	
	if Input.is_action_just_pressed("pick"):
		var did = pickup.pick_first(self)
		if did:
			act.emit(Actions.GRAB)
	
	if upgrades.has("Roll"):
		if Input.is_action_just_pressed("roll") and not move.direction.is_zero_approx():
			upgrades.Roll.roll()
			act.emit(Actions.ROLL)
	
	if upgrades.has("Defense"):
		if Input.is_action_just_pressed("defend"):
			upgrades.Defense.defend()
			act.emit(Actions.DEFEND)


func _on_hit() -> void:
	hit.emit()

func add_health(i):
	$Health.health += i
	update_health.emit()

func upgrade(string):
	if string == "Roll":
		var roll = Globals.add_script(self, "roll.gd", func(_n): return)
		roll.visual = $visual
		roll.hit = $Hit
		roll.pointer = $Pointer
		roll.pickup = $Pickup
		roll.move = $Mover
		roll.health = $Health
		expect.emit(Actions.ROLL)
		upgrades["Roll"] = roll
	elif string == "Defense":
		var def = Globals.add_script(self, "defense.gd", func(_n): return)
		def.p_hit = $Hit
		def.move = $Mover
		expect.emit(Actions.DEFEND)
		upgrades["Defense"] = def
	upgraded.emit(string)
