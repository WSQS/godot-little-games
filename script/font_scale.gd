class_name FontScale
extends Node

@export var base_theme: Theme = preload("res://theme/base_theme.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	get_viewport().size_changed.connect(setup_font_size)
	setup_font_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup_font_size():
	base_theme.default_font_size = get_viewport().get_visible_rect().size.y/20
	base_theme.set_type_variation("title","Control")
	base_theme.set_font_size("font_size","title",get_viewport().get_visible_rect().size.y/10)
	pass
