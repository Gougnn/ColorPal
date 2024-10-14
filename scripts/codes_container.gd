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

func update_label_codes(colors : Array[String], block_size : Vector2) -> void:
	color_steps = colors.size()
	show_used_childs(color_steps)
	get_visible_childs()
	
	for c in childs.size():
		childs[c].string_content = colors[c] if c < colors.size() else "000000"
		childs[c].is_vertical = true if block_size.x/color_steps < 100 else false
		childs[c].font_size = childs[c].adapt_font_size(Vector2(block_size.x/color_steps, block_size.y))


func isolate_colors(toggle : bool) -> void:
	for n in childs:
		n.is_isolated = toggle
