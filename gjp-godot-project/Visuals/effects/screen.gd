extends Node

signal change 
var changed = false

func transition():
	changed = false
	$AnimationPlayer.play("transition")

func to_change():
	change.emit()
	changed = true

func stop():
	if $AnimationPlayer.is_playing() && changed:
		$AnimationPlayer.stop()
