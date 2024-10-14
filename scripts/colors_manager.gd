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
var colors : Array[String]:
	set(value):
		colors = value
		if is_instance_valid(codes_container):
			codes_container.update_label_codes(value, size)
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

func custom_b10_to_b16( value : int ) -> String:
	var first_digit : int = floor(float(value) / 16.0)
	var second_digit : int = floor((value % 16))
	
	return str(from_10_to_16_base[int(first_digit)]) + str(from_10_to_16_base[int(second_digit)])

func color_to_hex(color : Color) -> String:
	return custom_b10_to_b16(color.r8) +\
		   custom_b10_to_b16(color.g8) +\
		   custom_b10_to_b16(color.b8)

func vector_cos(value : Vector3) -> Vector3:
	return Vector3(
		cos(value.x),
		cos(value.y),
		cos(value.z)
	)

func get_stepped_gradient(steps : float) -> Array[String]:
	var res : Array[String] = []
	var resolution : float = 1.0/(steps + 0.0)
	var x : float =0.0 + resolution*0.5
	
	for i in steps:
		var current_color : Vector3 = brightness + contrast * vector_cos(2.0 * PI *(frequency * x + shift))
		res.append(color_to_hex(Color(current_color.x, current_color.y, current_color.z)))
		x += resolution
	
	return res


func _ready() -> void:
	codes_container.update_label_codes(get_stepped_gradient(color_step), Vector2(378, 570))


func _on_resized():
	if is_instance_valid(codes_container):
		codes_container.update_label_codes(get_stepped_gradient(color_step), size)
