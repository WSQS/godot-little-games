class_name ResizeLabel
extends Label


# Called when the node enters the scene tree for the first time.
func _init_autofont() -> void:
	if not label_settings:
		label_settings = LabelSettings.new()
	resized.connect(_resized)

func _notification(what):
	if what == NOTIFICATION_READY:
		_init_autofont()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _resized():
	label_settings.font_size = int(size.y*0.6)
