extends ColorRect

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_value(value: int):
	match value:
		0:
			color = Color(0,0,0,0.6)
			label.text = ""
