extends Node2D

@onready var red_curve : Line2D = %Red
@onready var green_curve : Line2D = %Green
@onready var blue_curve : Line2D = %Blue

var resolution : float = 100
var brightness : Vector3:
	set(value):
		brightness = value
		if red_curve and green_curve and blue_curve:
			update_visualizer()
var contrast : Vector3:
	set(value):
		contrast = value
		if red_curve and green_curve and blue_curve:
			update_visualizer()
var frequency : Vector3:
	set(value):
		frequency = value
		if red_curve and green_curve and blue_curve:
			update_visualizer()
var shift : Vector3:
	set(value):
		shift = value
		if red_curve and green_curve and blue_curve:
			update_visualizer()


func _ready() -> void:
	red_curve.clear_points()
	green_curve.clear_points()
	blue_curve.clear_points()
	update_visualizer()


func bake_curve(curve : Line2D, br : float, co : float, fr : float, sh : float) -> void:
	var step : float = 2.0/resolution
	var x : float = 0.0
	var py : float
	
	for i in resolution:
		var y : float = br + co * cos(2.0 * PI *(fr * x + sh))
		if y != py:
			curve.add_point(Vector2(x, -y*0.5)*120)
		x += step
		py = y

func update_visualizer() -> void:
	red_curve.clear_points()
	bake_curve(red_curve, brightness.x, contrast.x, frequency.x, shift.x)
	green_curve.clear_points()
	bake_curve(green_curve, brightness.y, contrast.y, frequency.y, shift.y)
	blue_curve.clear_points()
	bake_curve(blue_curve, brightness.z, contrast.z, frequency.z, shift.z)
