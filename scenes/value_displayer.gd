extends Label

@export var slider : HSlider

func _ready():
	slider.value_changed.connect(_on_red_bri_slide_value_changed)
	_on_red_bri_slide_value_changed(slider.value)


func _on_red_bri_slide_value_changed(value):
	text = str(value).pad_decimals(2)
