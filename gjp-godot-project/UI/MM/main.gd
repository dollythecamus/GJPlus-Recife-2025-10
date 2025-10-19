extends Control

func _ready() -> void:
	$Title/Play.grab_focus.call_deferred()
	$Title/Play.connect("pressed", goto_main)

func goto_main():
	get_tree().change_scene_to_file("res://main.tscn")
