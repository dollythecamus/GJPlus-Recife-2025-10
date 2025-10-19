extends Node2D

@onready var pointer = $visual/Pointer

func fire():
	$Shooter.attack(false)
