@tool
extends SubViewport

@export var width : int:
	set(value):
		width = value
		size.x = value
@export var height : int:
	set(value):
		height = value
		size.y = value
