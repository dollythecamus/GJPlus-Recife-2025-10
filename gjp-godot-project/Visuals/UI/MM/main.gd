extends Control

func _ready() -> void:
	$Main/Title/Play.grab_focus.call_deferred()
	$Main/Title/Play.connect("pressed", goto_main)
	$Main/Title/Quit.connect("pressed", func(): get_tree().quit() )
	$Main/Title/tutorial.connect("pressed", goto_tutorial)
	$Tutorial/Quit.connect("pressed", back)

func goto_main():
	Screen.transition()
	await Screen.change
	get_tree().change_scene_to_file("res://Scenario/main.tscn")

func goto_tutorial():
	$Main.hide()
	$Tutorial.show()
	$Tutorial/Quit.grab_focus.call_deferred()
	Screen.visible = false

func back():
	$Main/Title/tutorial.grab_focus.call_deferred()
	Screen.visible = true
	$Main.show()
	$Tutorial.hide()
