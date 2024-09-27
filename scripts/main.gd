extends Control

const CARET_RIGHT_FILL = preload("res://assets/svg/caret-right-fill.svg")
const CARET_DOWN_FILL = preload("res://assets/svg/caret-down-fill.svg")

@onready var visualizer = %Visualizer
@onready var display = %Display
@onready var hex_codes = %HexCodes
@onready var rgb_codes = %RGBCodes

var color_step : float

var brightness : Vector3
var contrast : Vector3
var frequency : Vector3
var shift : Vector3


func _ready() -> void:
	_on_spin_box_value_changed(10)
	
	_on_red_bri_slide_value_changed(  0.42)
	_on_green_bri_slide_value_changed(0.34)
	_on_blue_bri_slide_value_changed( 0.33)
	
	_on_red_con_slide_value_changed(  0.63)
	_on_green_con_slide_value_changed(0.47)
	_on_blue_con_slide_value_changed( 0.38)
	
	_on_red_fre_slide_value_changed(  0.35)
	_on_green_fre_slide_value_changed(0.36)
	_on_blue_fre_slide_value_changed (0.29)
	
	_on_red_shi_slide_value_changed(  0.00)
	_on_green_shi_slide_value_changed(0.00)
	_on_blue_shi_slide_value_changed( 0.84)


func vector_cos(value : Vector3):
	return Vector3(
		cos(value.x),
		cos(value.y),
		cos(value.z)
	)
	
func get_gradient(steps : float):
	var colors : Array[Color] = []
	var res : float = 1.0/(steps+1.0)
	var x : float =0.0
	
	for i in steps:
		var current_color : Vector3 = brightness + contrast * vector_cos(2.0 * PI *(frequency * x + shift))
		colors.append(Color(current_color.x, current_color.y, current_color.z))
		x += res
	
	return colors

func update_hex(step : float) -> void:
	hex_codes.update_color_codes(get_gradient(step))



#region Slider Signal
func _on_red_bri_slide_value_changed(value) -> void:
	brightness.x = value
	visualizer.brightness.x = value
	display.material.set_shader_parameter("brightness", brightness)
	update_hex(color_step)

func _on_green_bri_slide_value_changed(value) -> void:
	brightness.y = value
	visualizer.brightness.y = value
	display.material.set_shader_parameter("brightness", brightness)
	update_hex(color_step)

func _on_blue_bri_slide_value_changed(value) -> void:
	brightness.z = value
	visualizer.brightness.z = value
	display.material.set_shader_parameter("brightness", brightness)
	update_hex(color_step)


func _on_red_con_slide_value_changed(value) -> void:
	contrast.x = value
	visualizer.contrast.x = value
	display.material.set_shader_parameter("contrast", contrast)
	update_hex(color_step)

func _on_green_con_slide_value_changed(value) -> void:
	contrast.y = value
	visualizer.contrast.y = value
	display.material.set_shader_parameter("contrast", contrast)
	update_hex(color_step)

func _on_blue_con_slide_value_changed(value) -> void:
	contrast.z = value
	visualizer.contrast.z = value
	display.material.set_shader_parameter("contrast", contrast)
	update_hex(color_step)


func _on_red_fre_slide_value_changed(value) -> void:
	frequency.x = value
	visualizer.frequency.x = value
	display.material.set_shader_parameter("frequency", frequency)
	update_hex(color_step)

func _on_green_fre_slide_value_changed(value) -> void:
	frequency.y = value
	visualizer.frequency.y = value
	display.material.set_shader_parameter("frequency", frequency)
	update_hex(color_step)

func _on_blue_fre_slide_value_changed(value) -> void:
	frequency.z = value
	visualizer.frequency.z = value
	display.material.set_shader_parameter("frequency", frequency)
	update_hex(color_step)


func _on_red_shi_slide_value_changed(value) -> void:
	shift.x = value
	visualizer.shift.x = value
	display.material.set_shader_parameter("shift", shift)
	update_hex(color_step)

func _on_green_shi_slide_value_changed(value) -> void:
	shift.y = value
	visualizer.shift.y = value
	display.material.set_shader_parameter("shift", shift)
	update_hex(color_step)

func _on_blue_shi_slide_value_changed(value) -> void:
	shift.z = value
	visualizer.shift.z = value
	display.material.set_shader_parameter("shift", shift)
	update_hex(color_step)
#endregion

func _on_spin_box_value_changed(value) -> void:
	color_step = value
	display.material.set_shader_parameter("steps", value)
	update_hex(value)

#region Button Signal
func _on_bri_title_pressed():
	%BriExpandable.visible = not %BriExpandable.visible
	%BriTitle.icon = CARET_DOWN_FILL if %BriExpandable.visible else CARET_RIGHT_FILL

func _on_con_title_pressed() -> void:
	%ConExpandable.visible = not %ConExpandable.visible
	%ConTitle.icon = CARET_DOWN_FILL if %ConExpandable.visible else CARET_RIGHT_FILL

func _on_fre_title_pressed() -> void:
	%FreExpandable.visible = not %FreExpandable.visible
	%FreTitle.icon = CARET_DOWN_FILL if %FreExpandable.visible else CARET_RIGHT_FILL

func _on_shi_title_pressed() -> void:
	%ShiExpandable.visible = not %ShiExpandable.visible
	%ShiTitle.icon = CARET_DOWN_FILL if %ShiExpandable.visible else CARET_RIGHT_FILL
#endregion
