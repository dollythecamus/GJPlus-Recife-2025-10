extends CanvasLayer

signal change 
var changed = false

var tints = [null, 
	{
		"intensity":2.5, 
		"tint":Color.DARK_ORANGE
	}, 
	{
		"intensity":4.0,
		"tint":Color.WEB_GREEN
	}
]

var configs = [
	null,
	{
		"resolution": Vector2(640, 440),
		"aberation_ammount": 0.3,
		"grille_ammount": 0.05,
		"grille_size": 1.0,
	},
	{
		"resolution": Vector2(320, 220),
		"aberation_ammount": 0.9,
		"grille_ammount": 0.2,
		"grille_size": 2.0,
	}
]

var x := 3

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swap"):
		swap_mode()

func _ready() -> void:
	set_visual()

func swap_mode():
	x = wrapi(x+1, 0, tints.size() * configs.size())
	set_visual()

func set_visual():
	@warning_ignore("integer_division")
	var t = tints[wrapi(x, 0, tints.size())]
	@warning_ignore("integer_division")
	var c = configs[wrapi(x / tints.size(), 0, configs.size())]
	if t != null:
		$Tint.show()
		for k in t.keys():
			$Tint.material.set_shader_parameter(k, t[k])
	else:
		$Tint.hide()
	if c != null:
		$CRT.show()
		for k in c.keys():
			$CRT/CRT.material.set_shader_parameter(k, c[k])
	else:
		$CRT.hide()

func transition():
	changed = false
	$AnimationPlayer.play("transition")

func down():
	x = 0
	set_visual()

func default():
	x = 3
	set_visual()

func to_change():
	change.emit()
	changed = true

func stop():
	if $AnimationPlayer.is_playing() && changed:
		$AnimationPlayer.stop()
