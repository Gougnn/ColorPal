extends Control

signal color_copied

const COPY = preload("res://assets/svg/copy_cursor.svg")

@onready var block = $Block
@onready var border = $Border

var fade : Tween
@export var string_content : String = '':
	set(value):
		string_content = value
		queue_redraw()
@export var font : Font = preload("res://assets/menu/Roboto-BoldCondensed.ttf"):
	set(value):
		font = value
		queue_redraw()
@export var font_size : int = 16:
	set(value):
		font_size = value
		queue_redraw()
@export var is_vertical : bool = false:
	set(value):
		is_vertical = value
		queue_redraw()
@export var is_isolated : bool = false:
	set(value):
		is_isolated = value
		queue_redraw()

#INITIALIZE
func _ready():
	Input.set_custom_mouse_cursor(COPY, Input.CURSOR_HELP)
	mouse_default_cursor_shape = Control.CURSOR_HELP
	grow_horizontal = Control.GROW_DIRECTION_BOTH
	grow_vertical = Control.GROW_DIRECTION_BOTH
	set_self_modulate(Color.TRANSPARENT)

#METHODES
func adapt_font_size(block_size : Vector2):
	return min(floor(block_size.x / 2), floor (block_size.y/ 8)) if is_vertical else \
		   floor(block_size.x / 5)

func get_string_size(string : String, vertical : bool):
	return font.get_string_size(
		string,
		HORIZONTAL_ALIGNMENT_CENTER,
		-1,
		font_size,
		TextServer.JUSTIFICATION_NONE, TextServer.DIRECTION_AUTO, 
		TextServer.ORIENTATION_VERTICAL if vertical else TextServer.ORIENTATION_HORIZONTAL
		)

func center_text(string : String, vertical : bool):
	var s = get_string_size(string, vertical)
	return Vector2(size.x * 0.5, (size.y * 0.5)-(s.y * 0.5)) if vertical else \
		   Vector2((size.x * 0.5)-(s.x*0.5), (size.y * 0.5)+(s.y * 0.3))

func set_contrast_color_text(color : String):
	return Color.WHITE if Color.from_string(color, Color.BLACK).get_luminance() < 0.5 else \
		   Color.BLACK

func draw_outline():
	if !is_isolated:
		border.hide()
	else:
		var thickness : int = floor(size.x * 0.075)
		var style_box : StyleBoxFlat = StyleBoxFlat.new()
		style_box.bg_color = Color.TRANSPARENT
		style_box.border_color = Color.WHITE
		style_box.border_width_bottom = thickness
		style_box.border_width_left = thickness
		style_box.border_width_top = thickness
		style_box.border_width_right = thickness
		
		border.set("theme_override_styles/panel", style_box)
		border.show()

func draw_color_block():
	block.set_self_modulate(Color.from_string(string_content, Color.BLACK))

func draw_string_content():
	font.draw_string(
		get_canvas_item(),
		center_text(string_content, is_vertical),
		string_content,
		HORIZONTAL_ALIGNMENT_CENTER,
		-1,
		font_size,
		set_contrast_color_text(string_content),
		TextServer.JUSTIFICATION_NONE, TextServer.DIRECTION_AUTO, 
		TextServer.ORIENTATION_VERTICAL if is_vertical else TextServer.ORIENTATION_HORIZONTAL
		)

#IMBEDDED FUNCTIONS
func _draw():
	draw_color_block()
	draw_outline()
	draw_string_content()

#SIGNAL
func _on_mouse_entered():
	if fade:
		fade.kill()
	fade = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT)
	fade.tween_property(self, "self_modulate:a", 1.0, 0.15)
	fade.tween_property(self, "size_flags_stretch_ratio", 1.3, 0.25)

func _on_mouse_exited():
	if fade:
		fade.kill()
	fade = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT)
	fade.tween_property(self, "self_modulate:a", 0.0, 0.25)
	fade.tween_property(self, "size_flags_stretch_ratio", 1, 0.25)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.double_click:
		DisplayServer.clipboard_set(string_content)
		emit_signal("color_copied")
