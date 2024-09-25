extends HBoxContainer


func color_to_text(color : Color) -> String:
	return str(color.r8) + ' ' + str(color.g8) + ' ' + str(color.b8)


func create_label(number : float, colors : Array[Color]) -> void:
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
	for i in number:
		var label : Label = Label.new()
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.size_flags_vertical = Control.SIZE_EXPAND_FILL
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		label.text = '\n\n' + color_to_text(colors[i])
		label.label_settings = LabelSettings.new()
		#label.label_settings.set_font_size(ceil(label.size.x)*0.25)
		label.label_settings.set_font_size(ceil((size.x/number) * 0.2 * 0.75))
		#print(label.size.x)
		label.label_settings.set_font_color(
			Color(0, 0, 0, 0.0) if (colors[i].get_luminance() > 0.5) else Color(1, 1, 1, 0.0)
		)
		
		label.mouse_filter = Control.MOUSE_FILTER_PASS
		label.mouse_entered.connect(alpha_in.bind(label))
		label.mouse_exited.connect(alpha_out.bind(label))
		
		add_child(label)

func alpha_in(label) -> void:
	label.create_tween().tween_property(
		label, "label_settings:font_color:a",
		0.5, 0.15
	)
	print("In RGB")

func alpha_out(label) -> void:
	label.create_tween().tween_property(
		label, "label_settings:font_color:a",
		0.0, 0.5
	)
