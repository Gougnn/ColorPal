extends Panel

@onready var hex = %Hex
@onready var rgb = %Rgb
@onready var border = %Border
@onready var code_manager = %CodeManager
var fade : Tween
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

var border_color : Color = Color.WHITE

func _ready():
	adapt_font_size(1)


func custom_b10_to_b16( value : int ):
	var first_digit : int = floor(float(value) / 16.0)
	var second_digit : int = floor((value % 16))
	
	return str(from_10_to_16_base[int(first_digit)]) + str(from_10_to_16_base[int(second_digit)])

func color_to_rgb(color : Color) -> String:
	return str(color.r8) + ' ' + str(color.g8) + ' ' + str(color.b8)

func color_to_hex(color : Color) -> String:
	return custom_b10_to_b16(color.r8) +\
		   custom_b10_to_b16(color.g8) +\
		   custom_b10_to_b16(color.b8)


func set_codes(color : Color):
	hex.text = color_to_hex(color)
	rgb.text = "\n\n\n" + color_to_rgb(color)

func adapt_font_size(value):
	hex["theme_override_font_sizes/font_size"] = int(value*16)
	rgb["theme_override_font_sizes/font_size"] = int(value*10)

func color_isolation(value):
	border.visible = value


func _on_mouse_entered():
	if fade:
		fade.kill()
	fade = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT)
	fade.tween_property(code_manager, "modulate:a", 1.0, 0.15)
	fade.tween_property(self, "size_flags_stretch_ratio", 1.5, 0.25)

func _on_mouse_exited():
	if fade:
		fade.kill()
	fade = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT)
	fade.tween_property(code_manager, "modulate:a", 0.0, 0.25)
	fade.tween_property(self, "size_flags_stretch_ratio", 1, 0.25)


func _on_gui_input(event):
	if event is InputEventMouseButton and event.double_click:
		DisplayServer.clipboard_set(hex.text)


func _on_resized():
	if not border.visible:
		return
	var box : StyleBox
	if size.x < 30:
		box = StyleBoxEmpty.new()
	else:
		box = StyleBoxFlat.new()
		box.bg_color = Color(0, 0, 0, 0)
		box.border_color = border_color
		box.border_width_bottom = size.x *0.05
		box.border_width_left = size.x *0.05
		box.border_width_top = size.x *0.05
		box.border_width_right = size.x *0.05

	border.set("theme_override_styles/panel", box)
