extends Window

var initialPos : Vector2

func _ready() -> void:
	size = Vector2i(612, 576)
	initialPos = self.get_position()

func _process(_delta) -> void:
	position = initialPos

func _on_close_requested() -> void:
	get_tree().get_root().max_size.x = 32768
	queue_free()

