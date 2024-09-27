extends HBoxContainer

const CUSTOM_LABEL = preload("res://scenes/custom_label.tscn")
var from_10_to_16_base : Dictionary = {
	0: '0',
	1: '1',
	2: '2',
	3: '3',
	4: '4',
	5: '5',
	6: '6',
	7: '7',
	8: '8',
	9: '9',
	10: 'A',
	11: 'B',
	12: 'C',
	13: 'D',
	14: 'E',
	15: 'F',
	}
@onready var rgb_codes = %RGBCodes

func reset_children(node : Node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func update_color_codes(colors : Array[Color]) -> void:
	reset_children(self)
	
	for i in colors.size():
		var label = CUSTOM_LABEL.instantiate()
		label.background_color = colors[i]
		label.siblings_number = colors.size()
		label.ready.connect(upl.bind(label))
		add_child(label)
	
	#for n in get_children():
		#n.set_text_codes()
		#n.adapt_font_size()

func upl(n):
	n.set_text_codes()
	n.adapt_font_size()
