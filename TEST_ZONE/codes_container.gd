extends HBoxContainer

var childs : Array[Node]
var visible_childs : Array[Node]
var color_steps : int = 3
@onready var gradient = %Gradient


func _ready():
	childs = get_children()
	show_used_childs(color_steps)


func get_visible_childs():
	visible_childs.clear()
	for n in childs:
		if n.visible:
			visible_childs.append(n)

func show_used_childs(steps):
	var count = 0
	for n in childs:
		if count < steps:
			n.show()
		else: n.hide()
		count += 1

func update_label_codes(colors : Array[Color]):
	color_steps = colors.size()
	show_used_childs(color_steps)
	get_visible_childs()
	
	for c in color_steps:
		visible_childs[c].color_to_display = colors[c]
		visible_childs[c].set_vertical_or_horizontal(gradient.size.x / visible_childs.size() < 80)
	
	font_size()

func font_size():
	for n in visible_childs:
		n.adapt_font_size(min(max(size.x/float(color_steps)/60.0, 0.5), 2))

func isolate_colors(toggle : bool):
	for n in childs:
		n.color_isolation(toggle and gradient.size.x / visible_childs.size() > 80, gradient.size.x / visible_childs.size())


func _on_resized():
	font_size()
