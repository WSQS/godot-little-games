extends GridContainer

enum Side{
	RED,
	BLUE
}

var cells:Array
var side:int = Side.RED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cell :PackedScene = load("res://scene/cell.tscn")
	if cell is PackedScene and cell.can_instantiate():
		for i in range(0,9):
			var cell_node:Cell = cell.instantiate()
			cell_node.id = i
			cell_node.cell_trigger.connect(process_cell_trugger)
			add_child(cell_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func process_cell_trugger(cell:Cell,id:int):
	prints(id)
	var newbox :StyleBoxFlat = StyleBoxFlat.new()
	if side == Side.RED:
		newbox.bg_color = Color(1,0,0,0.6)
		side = Side.BLUE
	else:
		newbox.bg_color = Color(0,0,1,0.6)
		side = Side.RED
	
	cell.add_theme_stylebox_override("disabled",newbox)
	cell.disabled = true
	pass
