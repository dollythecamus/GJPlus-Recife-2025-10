extends Node2D
class_name BotGun

@onready var pointer = $visual/Pointer

var fire_cycle = .8
var fc = randf()/fire_cycle

func run(delta):
	fc += delta
	
	if fc >= fire_cycle:
		fire()
		fc = 0.0

func fire():
	$Shooter.attack(false)
