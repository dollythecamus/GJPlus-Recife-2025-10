extends Node

var expected = 0
var learned = 0

func player_acted(what):
	match what:
		PlayerControls.Actions.SHOOT:
			$H/Shoot.hide()
			learned += 1
		PlayerControls.Actions.GRAB:
			$H/Grab.hide()
			learned += 2
		PlayerControls.Actions.ROLL:
			$H/Roll.hide()
			learned += 4
		PlayerControls.Actions.DEFEND:
			$H/Defend.hide()
			learned += 8
		PlayerControls.Actions.MOVEAIM:
			$H/"Move-Aim".hide()
			learned += 16

func expect_player(what):
	# TODO: this kinda math so that the player is expected to do things they didn't learn but not things they leadnerd
	
	var diff = expected - learned
	
	if diff == 0:
		return
	
	match what:
		PlayerControls.Actions.SHOOT:
			$H/Shoot.show()
			expected += 1
		PlayerControls.Actions.GRAB:
			$H/Grab.show()
			expected += 2
		PlayerControls.Actions.ROLL:
			$H/Roll.show()
			expected += 4
		PlayerControls.Actions.DEFEND:
			$H/Defend.show()
			expected += 8
		PlayerControls.Actions.MOVEAIM:
			$H/"Move-Aim".show()
			expected += 16
