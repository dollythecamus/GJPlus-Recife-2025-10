extends Node2D
class_name BotGun

var n
var mover
@onready var pointer = $visual/Pointer

@export var recoil = 90.0

var fire_cycle = .8
var fc = randf()/fire_cycle

func _ready() -> void:
	$Shooter.owns = n

func run(delta):
	fc += delta
	
	if fc >= fire_cycle:
		fire()
		fc = 0.0

func fire():
	$Shooter.attack()
	mover.velocity -= Vector2.from_angle(pointer.global_rotation) * recoil
