extends Node2D

const ROBOTO_BOLD_CONDENSED = preload("res://assets/menu/Roboto-BoldCondensed.ttf")
@export_range(50, 200, 1) var resolution : int = 100:
	set(value):
		resolution = value
		queue_redraw()
@export_range(50, 400, 1) var width : float = 200:
	set(value):
		width = value
		queue_redraw()
@export_range(50, 400, 1) var height : float = 50:
	set(value):
		height = value
		queue_redraw()
@export var brightness : Vector3:
	set(value):
		brightness = value
		queue_redraw()
@export var contrast : Vector3:
	set(value):
		contrast = value
		queue_redraw()
@export var frequency : Vector3:
	set(value):
		frequency = value
		queue_redraw()
@export var shift : Vector3:
	set(value):
		shift = value
		queue_redraw()
@export var color_step : float = 10:
	set(value):
		color_step = value
		queue_redraw()

func vector_cos(value : Vector3) -> Vector3:
	return Vector3(
		cos(value.x),
		cos(value.y),
		cos(value.z)
	)

func create_points_rgb(a, b, c, d):
	var x : float = 0
	var res : PackedVector2Array = []
	for i in resolution:
		res.append(Vector2(x*width, -clamp(a +b * (cos(TAU*(c*(x)+d))), 0.0, 1.0)*height+height+2))
		x += 1.0/resolution
	
	return res

func create_points_luminance(a, b, c, d):
	var x : float = 0
	var res : PackedVector2Array = []
	for i in resolution:
		var colvec = Vector3(a +b * (vector_cos(TAU*(c*(x)+d)))*height+height+2)
		var color = Color(colvec.x, colvec.y, colvec.z)
		res.append(Vector2(x * width, -color.get_luminance()))
		x += 1.0/resolution
	
	return res

func _draw():
	for s in color_step:
		var x = (s/color_step + 0.5/color_step) * width
		draw_line(Vector2(x, 0), Vector2(x, height + 4), Color("282828"), -1, true)
	draw_string(ROBOTO_BOLD_CONDENSED, Vector2(2,95), '0', HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color("686868"))
	draw_string(ROBOTO_BOLD_CONDENSED, Vector2(2,17), '1', HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color("686868"))
	draw_polyline(create_points_rgb(brightness.x, contrast.x, frequency.x, shift.x), Color.LIGHT_CORAL, 2.0, true)
	draw_polyline(create_points_rgb(brightness.y, contrast.y, frequency.y, shift.y), Color.LIGHT_GREEN, 2.0, true)
	draw_polyline(create_points_rgb(brightness.z, contrast.z, frequency.z, shift.z), Color.LIGHT_SEA_GREEN, 2.0, true)







