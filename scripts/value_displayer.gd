extends Label

@export var slider : HSlider


func _ready() -> void:
	slider.value_changed.connect(_on_slider_value_changed)
	_on_slider_value_changed(slider.value)


func _on_slider_value_changed(value : float) -> void:
	text = str(value).pad_decimals(2)
