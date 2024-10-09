extends PanelContainer

@onready var gradient = %Gradient
@onready var codes_container = %CodesContainer

var color_step : float = 10:
	set(value):
		color_step = value
		colors = get_stepped_gradient(value)
var is_gradient : bool = false:
	set(value):
		is_gradient = value
		if is_instance_valid(codes_container):
			codes_container.visible = not value
var is_isolated_color : bool = false:
	set(value):
		is_isolated_color = value
		if is_instance_valid(codes_container):
			codes_container.isolate_colors(value)

var brightness : Vector3:
	set(value):
		brightness = value
		colors = get_stepped_gradient(color_step)
		if is_instance_valid(gradient):
			gradient.material.set_shader_parameter("brightness", value)
var contrast : Vector3:
	set(value):
		contrast = value
		colors = get_stepped_gradient(color_step)
		if is_instance_valid(gradient):
			gradient.material.set_shader_parameter("contrast", value)
var frequency : Vector3:
	set(value):
		frequency = value
		colors = get_stepped_gradient(color_step)
		if is_instance_valid(gradient):
			gradient.material.set_shader_parameter("frequency", value)
var shift : Vector3:
	set(value):
		shift = value
		colors = get_stepped_gradient(color_step)
		if is_instance_valid(gradient):
			gradient.material.set_shader_parameter("shift", value)

var colors : Array[Color]:
	set(value):
		colors = value
		if is_instance_valid(codes_container):
			codes_container.update_label_codes(value)


func vector_cos(value : Vector3) -> Vector3:
	return Vector3(
		cos(value.x),
		cos(value.y),
		cos(value.z)
	)

func get_stepped_gradient(steps : float) -> Array[Color]:
	var res : Array[Color] = []
	var resolution : float = 1.0/(steps + 0.0)
	var x : float =0.0 + resolution*0.5
	
	for i in steps:
		var current_color : Vector3 = brightness + contrast * vector_cos(2.0 * PI *(frequency * x + shift))
		res.append(Color(current_color.x, current_color.y, current_color.z))
		x += resolution
	
	return res


func _ready() -> void:
	codes_container.update_label_codes(get_stepped_gradient(color_step))
