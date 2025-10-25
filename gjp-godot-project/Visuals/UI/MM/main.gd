extends Control

func _ready() -> void:
	$Main/Title/Play.grab_focus.call_deferred()
	$Main/Title/Play.connect("pressed", goto_main)
	
	$Main/Title/V/Quit.connect("pressed", func(): get_tree().quit() )
	$Main/Title/V/Tutorial.connect("pressed", goto_tutorial)
	$Main/Title/V/Credits.connect("pressed", goto_credits)
	
	$Tutorial/Quit.connect("pressed", back)
	$Tutorial/Toggle.connect("toggled", toggle_controls)
	
	$Credits/Quit.connect("pressed", back)

func goto_main():
	Screen.transition()
	await Screen.change
	get_tree().change_scene_to_file("res://Scenario/main.tscn")

func goto_tutorial():
	$Main.hide()
	$Tutorial.show()
	$Tutorial/Quit.grab_focus.call_deferred()
	Screen.down()

func goto_credits():
	$Main.hide()
	$Credits.show()
	$Credits/Quit.grab_focus.call_deferred()
	Screen.down()

func toggle_controls(toggle):
	$Tutorial/Joycon.visible = not toggle
	$Tutorial/Keyboard.visible = toggle

func back():
	$Main/Title/Play.grab_focus.call_deferred()
	Screen.default()
	$Main.show()
	$Tutorial.hide()
	$Credits.hide()
