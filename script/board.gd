extends GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cell :PackedScene = load("res://scene/cell.tscn")
	if cell is PackedScene and cell.can_instantiate():
		for i in range(0,9):
			var cell_node:Cell = cell.instantiate()
			cell_node.col = i%3+1;
			cell_node.row = i/3 + 1;
			add_child(cell_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
