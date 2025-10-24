extends Node2D

var clock = 0.0

func _process(delta: float) -> void:
	clock += delta
	get_child(0).position.y += sin((clock) * 7) * .25

func roman(num):
	if not (num <= 3999 and num >= 1):
		return

	var roman_map = [
		[1000, 'M'], [900, 'CM'], [500, 'D'], [400, 'CD'],
		[100, 'C'], [90, 'XC'], [50, 'L'], [40, 'XL'],
		[10, 'X'], [9, 'IX'], [5, 'V'], [4, 'IV'], [1, 'I']
	]
	
	var roman_numeral = ""
	
	for i in roman_map:
		var value = i[0]
		var symbol = i[1]
		
		while num >= value:
			roman_numeral += symbol
			num -= value
	
	$roman.text = roman_numeral
