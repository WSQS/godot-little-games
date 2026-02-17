extends GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cell :PackedScene = load("res://scene/cell.tscn")
	if cell is PackedScene and cell.can_instantiate():
		for i in range(1,10):
			var cell_node:Button = cell.instantiate()
			add_child(cell_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
