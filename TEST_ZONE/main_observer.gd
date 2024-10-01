extends Control


const CHEVRON_RIGHT = preload("res://assets/svg/chevron-right.svg")
const CHEVRON_DOWN = preload("res://assets/svg/chevron-down.svg")

@onready var colors_manager = %ColorsManager

@onready var red_bri_slide = %RedBriSlide
@onready var green_bri_slide = %GreenBriSlide
@onready var blue_bri_slide = %BlueBriSlide
@onready var red_con_slide = %RedConSlide
@onready var green_con_slide = %GreenConSlide
@onready var blue_con_slide = %BlueConSlide
@onready var red_fre_slide = %RedFreSlide
@onready var green_fre_slide = %GreenFreSlide
@onready var blue_fre_slide = %BlueFreSlide
@onready var red_shi_slide = %RedShiSlide
@onready var green_shi_slide = %GreenShiSlide
@onready var blue_shi_slide = %BlueShiSlide
@onready var spin_box = %SpinBox

var rng = RandomNumberGenerator.new()


func _ready():
	get_window().set_min_size(Vector2i(600, 529))
	randomize()
	_on_random_pressed()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			spin_box.value += 1
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			spin_box.value -= 1

#region COLLAPSABLE MENUS
func _on_bri_button_toggled(toggled_on):
	%BriExpandable.visible = not toggled_on
	%BriButton.icon = CHEVRON_DOWN if not toggled_on else CHEVRON_RIGHT
	%BriButton.release_focus()
	get_window().min_size.y += 65 if not toggled_on else -65

func _on_con_button_toggled(toggled_on):
	%ConExpandable.visible = not toggled_on
	%ConButton.icon = CHEVRON_DOWN if not toggled_on else CHEVRON_RIGHT
	%ConButton.release_focus()
	get_window().min_size.y += 65 if not toggled_on else -65

func _on_fre_button_toggled(toggled_on):
	%FreExpandable.visible = not toggled_on
	%FreButton.icon = CHEVRON_DOWN if not toggled_on else CHEVRON_RIGHT
	%FreButton.release_focus()
	get_window().min_size.y += 65 if not toggled_on else -65

func _on_shi_button_toggled(toggled_on):
	%ShiExpandable.visible = not toggled_on
	%ShiButton.icon = CHEVRON_DOWN if not toggled_on else CHEVRON_RIGHT
	%ShiButton.release_focus()
	get_window().min_size.y += 65 if not toggled_on else -65

func _on_display_toggled(toggled_on):
	%DisExpandable.visible = not toggled_on
	%DisButton.icon = CHEVRON_DOWN if not toggled_on else CHEVRON_RIGHT
	%DisButton.release_focus()
	get_window().min_size.y += 73 if not toggled_on else -73
	
func _on_gra_button_toggled(toggled_on):
	%GraExpandable.visible = not toggled_on
	%GraButton.icon = CHEVRON_DOWN if not toggled_on else CHEVRON_RIGHT
	%GraButton.release_focus()
	get_window().min_size.y += 125 if not toggled_on else -125
#endregion

#region SLIDERS
func _on_red_bri_slide_value_changed(value):
	colors_manager.brightness.x = value

func _on_green_bri_slide_value_changed(value):
	colors_manager.brightness.y = value

func _on_blue_bri_slide_value_changed(value):
	colors_manager.brightness.z = value

func _on_red_con_slide_value_changed(value):
	colors_manager.contrast.x = value

func _on_green_con_slide_value_changed(value):
	colors_manager.contrast.y = value
	
func _on_blue_con_slide_value_changed(value):
	colors_manager.contrast.z = value

func _on_red_fre_slide_value_changed(value):
	colors_manager.frequency.x = value

func _on_green_fre_slide_value_changed(value):
	colors_manager.frequency.y = value

func _on_blue_fre_slide_value_changed(value):
	colors_manager.frequency.z = value

func _on_red_shi_slide_value_changed(value):
	colors_manager.shift.x = value

func _on_green_shi_slide_value_changed(value):
	colors_manager.shift.y = value

func _on_blue_shi_slide_value_changed(value):
	colors_manager.shift.z = value
#endregion

func semi_dependant_vector_randomness(
		base_range_start : float, base_range_end : float,
		mod_range_start : float, mod_range_end : float
		):
	var base = rng.randf_range(base_range_start, base_range_end)
	var mod = rng.randf_range(mod_range_start, mod_range_end)
	
	var res = [base, base + mod, base - mod]
	res.shuffle()
	
	return Vector3(res[0], res[1], res[2])

func _on_random_pressed():
	var brightness : Vector3 = semi_dependant_vector_randomness(0.4, 0.6, -0.2, 0.2)
	red_bri_slide.value = brightness.x
	green_bri_slide.value = brightness.y
	blue_bri_slide.value = brightness.z
	var contrast : Vector3 = semi_dependant_vector_randomness(0.4, 0.6, -0.2, 0.2)
	red_con_slide.value = contrast.x
	green_con_slide.value = contrast.y
	blue_con_slide.value = contrast.z
	var frequency = Vector3(rng.randf_range(0.2, 1.0), rng.randf_range(0.2, 1.0),rng. randf_range(0.2, 1.0))
	red_fre_slide.value = frequency.x
	green_fre_slide.value = frequency.y
	blue_fre_slide.value = frequency.z
	var shift = Vector3(rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0))
	red_shi_slide.value = shift.x
	green_shi_slide.value = shift.y
	blue_shi_slide.value = shift.z


func _on_gradient_toggled(toggled_on):
	colors_manager.is_gradient = toggled_on

func _on_spin_box_value_changed(value):
	colors_manager.color_step = value
	spin_box.release_focus()

func _on_isolate_toggled(toggled_on):
	colors_manager.codes_container.isolate_colors(toggled_on)
