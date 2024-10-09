extends SubViewportContainer

@onready var curves_draw = $SubViewport/CurvesDraw

var brightness : Vector3:
	set(value):
		brightness = value
		if is_instance_valid(curves_draw):
			curves_draw.brightness = value
var contrast : Vector3:
	set(value):
		contrast = value
		if is_instance_valid(curves_draw):
			curves_draw.contrast = value
var frequency : Vector3:
	set(value):
		frequency = value
		if is_instance_valid(curves_draw):
			curves_draw.frequency = value
var shift : Vector3:
	set(value):
		shift = value
		if is_instance_valid(curves_draw):
			curves_draw.shift = value
var color_step : float:
	set(value):
		color_step = value
		if is_instance_valid(curves_draw):
			curves_draw.color_step = value
