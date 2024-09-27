extends Label

var background_color : Color
var siblings_number : float
var fade : Tween
var font_size : float = 1
@onready var hex = $HEX

func color_to_rgb(color : Color) -> String:
	return str(color.r8) + ' ' + str(color.g8) + ' ' + str(color.b8)

func color_to_hex(color : Color) -> String:
	return String.num_int64(color.r8, 16, true) +\
		   String.num_int64(color.g8, 16, true) +\
		   String.num_int64(color.b8, 16, true)

func get_dynamic_font_size(rect_size : float):
	return rect_size/80

func _ready():
	print("label ready")
	modulate = Color.BLACK if background_color.get_luminance() > 0.5 else Color.WHITE
	modulate.a = 1

func set_text_codes():
	text = '\n\n\n' + color_to_rgb(background_color)
	hex.text =color_to_hex(background_color)
	

func adapt_font_size():
	font_size = min(max(get_dynamic_font_size(size.x), 0.5), 4)
	if size.x > 10:# and 150 > size.x:
		self["theme_override_font_sizes/font_size"] = int(font_size*10)
		hex["theme_override_font_sizes/font_size"] = int(font_size*16)
		


func _on_hex_mouse_entered():
	if fade:
		fade.kill()
	fade = create_tween()
	fade.tween_property(self, "modulate:a", 1.0, 0.15)


func _on_hex_mouse_exited():
	if fade:
		fade.kill()
	fade = create_tween()
	fade.tween_property(self, "modulate:a", 1.0, 0.25)


func _on_hex_gui_input(event):
	if event is InputEventMouseButton and event.double_click:
		DisplayServer.clipboard_set(hex.text)


func _on_resized():
	#adapt_font_size()
	pass
