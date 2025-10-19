extends Control

func _ready() -> void:
	$Main/Title/Play.grab_focus.call_deferred()
	$Main/Title/Play.connect("pressed", goto_main)
	$Main/Title/tutorial.connect("pressed", goto_tutorial)
	$Tutorial/Quit.connect("pressed", back)

func goto_main():
	get_tree().change_scene_to_file("res://main.tscn")

func goto_tutorial():
	$Main.hide()
	$Tutorial.show()
	$Tutorial/Quit.grab_focus.call_deferred()

func back():
	$Main/Title/tutorial.grab_focus.call_deferred()
	$Main.show()
	$Tutorial.hide()
