extends HBoxContainer

@onready var gradient = %Gradient

var childs : Array[Node]
var visible_childs : Array[Node]
var color_steps : int = 10


func _ready() -> void:
	childs = get_children()
	show_used_childs(color_steps)


func get_visible_childs() -> void:
	visible_childs.clear()
	for n in childs:
		if n.visible:
			visible_childs.append(n)

func show_used_childs(steps : int) -> void:
	var count : int = 0
	for n in childs:
		if count < steps:
			n.show()
		else: n.hide()
		count += 1

func update_label_codes(colors : Array[Color]) -> void:
	color_steps = colors.size()
	show_used_childs(color_steps)
	get_visible_childs()
	
	for c in color_steps:
		visible_childs[c].color_to_display = colors[c]
		visible_childs[c].set_vertical_or_horizontal(gradient.size.x / visible_childs.size() < 80)
	
	font_size()

func font_size() -> void:
	for n in visible_childs:
		n.adapt_font_size(min(max(size.x/float(color_steps)/60.0, 0.5), 2))

func isolate_colors(toggle : bool) -> void:
	for n in childs:
		n.color_isolation(toggle and gradient.size.x / visible_childs.size() > 80, gradient.size.x / visible_childs.size())


func _on_resized() -> void:
	font_size()
	for c in visible_childs.size():
		visible_childs[c].set_vertical_or_horizontal(gradient.size.x / visible_childs.size() < 80)
