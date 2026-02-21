extends GridContainer

@export
var scene_block: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(16):
		var b = scene_block.instantiate()
		add_child(b)
		b.set_value(0)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func swipe(direction: String):
	print(direction)
	pass
