extends ColorRect

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_value(value: int):
	if value == 0:
		label.text = ""
	else:
		label.text = str(value)
	match value:
		0: color = Color(0.1,0.1,0.1,0.6)
		2:    color = Color(0.93, 0.89, 0.85, 0.9) # #EEE4DA
		4:    color = Color(0.93, 0.88, 0.78, 0.9) # #EDE0C8
		8:    color = Color(0.95, 0.69, 0.47, 0.9) # #F2B179
		16:   color = Color(0.96, 0.58, 0.39, 0.9) # #F59563
		32:   color = Color(0.96, 0.49, 0.37, 0.9) # #F67C5F
		64:   color = Color(0.96, 0.37, 0.23, 0.9) # #F65E3B

		128:  color = Color(0.93, 0.81, 0.45, 0.9) # #EDCF72
		256:  color = Color(0.93, 0.80, 0.38, 0.9) # #EDCC61
		512:  color = Color(0.93, 0.78, 0.31, 0.9) # #EDC850
		1024: color = Color(0.93, 0.76, 0.24, 0.9) # #EDC53F
		2048: color = Color(0.93, 0.75, 0.18, 0.9) # #EDC22E
