extends HBoxContainer

const CUSTOM_LABEL = preload("res://scenes/custom_label.tscn")
var childs : Array[Node]
var visible_childs : Array[Node]
var color_steps : int = 3

func _ready():
	childs = get_children()
	show_used_childs(color_steps)

func get_visible_childs():
	visible_childs.clear()
	for c in childs:
		if c.visible:
			visible_childs.append(c)

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
	
	for i in color_steps:
		visible_childs[i].self_modulate = colors[i]
		visible_childs[i].set_codes(colors[i])
	
	font_size()

func font_size():
	for i in visible_childs:
		i.adapt_font_size(min(max(size.x/float(color_steps)/60.0, 0.5), 4))

func isolate_colors(toggle : bool):
	for c in childs:
		c.border.visible = toggle


func _on_resized():
	font_size()
