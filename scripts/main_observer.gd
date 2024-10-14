extends Control


@onready var initial_popup = $InitialPopup
@onready var colors_manager : PanelContainer = %ColorsManager
@onready var red_bri_slide : HSlider = %RedBriSlide
@onready var green_bri_slide : HSlider = %GreenBriSlide
@onready var blue_bri_slide : HSlider = %BlueBriSlide
@onready var red_con_slide : HSlider = %RedConSlide
@onready var green_con_slide : HSlider = %GreenConSlide
@onready var blue_con_slide : HSlider = %BlueConSlide
@onready var red_fre_slide : HSlider = %RedFreSlide
@onready var green_fre_slide : HSlider = %GreenFreSlide
@onready var blue_fre_slide : HSlider = %BlueFreSlide
@onready var red_shi_slide : HSlider = %RedShiSlide
@onready var green_shi_slide : HSlider = %GreenShiSlide
@onready var blue_shi_slide : HSlider = %BlueShiSlide
@onready var spin_box : SpinBox = %SpinBox
@onready var curves_display = %CurvesDisplay

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var path_to_settings : String = "user://settings.cfg"


func load_settings(path : String) -> void:
	var config : ConfigFile = ConfigFile.new()
	var data : Error = config.load(path)
	if data != OK:
		initial_popup.show()
		config.set_value("Init", "FirstLaunch", true)
		config.set_value("Colors", "brightness", Vector3(0.53, 0.41, 0.47))
		config.set_value("Colors", "contrast", Vector3(0.5, 0.31, 0.23))
		config.set_value("Colors", "frequency", Vector3(0.41, 0.54, 0.35))
		config.set_value("Colors", "shift", Vector3(0.85, 0.79, 0.54))
		config.set_value("Colors", "steps", 10.0)
		config.save(path)
	
	if config.get_value("Init", "FirstLaunch", true):
		initial_popup.show()
		config.set_value("Init", "FirstLaunch", false)
		config.save(path)
	
	var brightness : Vector3 = config.get_value("Colors", "brightness")
	red_bri_slide.value = brightness.x
	green_bri_slide.value = brightness.y
	blue_bri_slide.value = brightness.z
	var contrast : Vector3 = config.get_value("Colors", "contrast")
	red_con_slide.value = contrast.x
	green_con_slide.value = contrast.y
	blue_con_slide.value = contrast.z
	var frequency : Vector3 = config.get_value("Colors", "frequency")
	red_fre_slide.value = frequency.x
	green_fre_slide.value = frequency.y
	blue_fre_slide.value = frequency.z
	var shift : Vector3 = config.get_value("Colors", "shift")
	red_shi_slide.value = shift.x
	green_shi_slide.value = shift.y
	blue_shi_slide.value = shift.z
	var color_step : float = config.get_value("Colors", "steps")
	spin_box.value = color_step


func _ready() -> void:
	if OS.has_feature("editor"):
		path_to_settings = "res://settings.cfg"
	load_settings(path_to_settings)
		
	get_window().set_min_size(Vector2i(628, 621))
	get_window().max_size.x = get_window().min_size.x if initial_popup.visible else 32768
	
	randomize()
	


#region SLIDERS
func _on_red_bri_slide_value_changed(value : float) -> void:
	colors_manager.brightness.x = value
	curves_display.brightness.x = value

func _on_green_bri_slide_value_changed(value : float) -> void:
	colors_manager.brightness.y = value
	curves_display.brightness.y = value

func _on_blue_bri_slide_value_changed(value : float) -> void:
	colors_manager.brightness.z = value
	curves_display.brightness.z = value

func _on_red_con_slide_value_changed(value : float) -> void:
	colors_manager.contrast.x = value
	curves_display.contrast.x = value

func _on_green_con_slide_value_changed(value : float) -> void:
	colors_manager.contrast.y = value
	curves_display.contrast.y = value
	
func _on_blue_con_slide_value_changed(value : float) -> void:
	colors_manager.contrast.z = value
	curves_display.contrast.z = value

func _on_red_fre_slide_value_changed(value : float) -> void:
	colors_manager.frequency.x = value
	curves_display.frequency.x = value

func _on_green_fre_slide_value_changed(value : float) -> void:
	colors_manager.frequency.y = value
	curves_display.frequency.y = value

func _on_blue_fre_slide_value_changed(value : float) -> void:
	colors_manager.frequency.z = value
	curves_display.frequency.z = value

func _on_red_shi_slide_value_changed(value : float) -> void:
	colors_manager.shift.x = -value
	curves_display.shift.x = -value

func _on_green_shi_slide_value_changed(value : float) -> void:
	colors_manager.shift.y = -value
	curves_display.shift.y = -value
func _on_blue_shi_slide_value_changed(value : float) -> void:
	colors_manager.shift.z = -value
	curves_display.shift.z = -value
#endregion

#region DISPLAY PARAMETERS
func _on_gradient_toggled(toggled_on : bool) -> void:
	colors_manager.is_gradient = toggled_on

func _on_isolate_toggled(toggled_on : bool) -> void:
	colors_manager.codes_container.isolate_colors(toggled_on)

func _on_spin_box_value_changed(value : int) -> void:
	colors_manager.color_step = value
	curves_display.color_step = value
	spin_box.release_focus()
#endregion

func semi_dependant_vector_randomness(
		base_range_start : float, base_range_end : float,
		mod_range_start : float, mod_range_end : float
		) -> Vector3:
	var base : float = rng.randf_range(base_range_start, base_range_end)
	var mod : float = rng.randf_range(mod_range_start, mod_range_end)
	
	var res : Array[float] = [base, base + mod, base - mod]
	res.shuffle()
	
	return Vector3(res[0], res[1], res[2])

func _on_random_pressed() -> void:
	var brightness : Vector3 = semi_dependant_vector_randomness(0.4, 0.6, -0.3, 0.3)
	red_bri_slide.value = brightness.x
	green_bri_slide.value = brightness.y
	blue_bri_slide.value = brightness.z
	var contrast : Vector3 = semi_dependant_vector_randomness(0.4, 0.6, -0.3, 0.3)
	red_con_slide.value = contrast.x
	green_con_slide.value = contrast.y
	blue_con_slide.value = contrast.z
	var frequency : Vector3 = Vector3(rng.randf_range(0.1, 0.5), 
									  rng.randf_range(0.1, 0.5),
									  rng. randf_range(0.1, 0.5))
	red_fre_slide.value = frequency.x
	green_fre_slide.value = frequency.y
	blue_fre_slide.value = frequency.z
	var shift : Vector3 = Vector3(rng.randf_range(0.0, 1.0), 
								  rng.randf_range(0.0, 1.0), 
								  rng.randf_range(0.0, 1.0))
	red_shi_slide.value = shift.x
	green_shi_slide.value = shift.y
	blue_shi_slide.value = shift.z

func _on_colors_manager_gui_input(event : InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			spin_box.value += 1
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			spin_box.value -= 1


#REDIRECT to Inigo Quilez blog
func _on_rich_text_label_meta_clicked(meta) -> void:
	OS.shell_open(str(meta))

func _notification(what) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var config : ConfigFile = ConfigFile.new()
		var data : Error = config.load(path_to_settings)
		if data != OK:
			return
		
		config.set_value("Colors", "brightness", colors_manager.brightness)
		config.set_value("Colors", "contrast", colors_manager.contrast)
		config.set_value("Colors", "frequency", colors_manager.frequency)
		config.set_value("Colors", "shift", -colors_manager.shift)
		config.set_value("Colors", "steps", colors_manager.color_step)
		
		config.save(path_to_settings)
		get_tree().quit()

