extends Button


@export var expandable_part : Control
@export var icon_open : CompressedTexture2D
@export var icon_closed : CompressedTexture2D

func _ready():
	self.toggled.connect(_on_toggled)

func _on_toggled(toggled_on):
	expandable_part.visible = not toggled_on
	icon = icon_open if toggled_on else icon_closed
	release_focus()
	get_window().min_size.y += int(-expandable_part.size.y if toggled_on else expandable_part.size.y)
