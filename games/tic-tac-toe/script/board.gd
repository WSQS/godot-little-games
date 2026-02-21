extends GridContainer

var cells:Array[Cell]
var side:TicEnum.BoardSide = TicEnum.BoardSide.RED

signal on_side(current_side: TicEnum.BoardSide)
signal on_finish(winner: TicEnum.BoardSide)

@export
var cell: PackedScene

@export
var n_row: int

@export
var n_col: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	columns = n_col
	if cell is PackedScene and cell.can_instantiate():
		for i in range(0,9):
			var cell_node:Cell = cell.instantiate()
			cell_node.id = i
			cell_node.cell_trigger.connect(process_cell_trugger)
			add_child(cell_node)
			cells.append(cell_node)
	emit_signal("on_side",side)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func process_cell_trugger(id:int):
	prints(id)
	cells[id].flip(side)
	if side == TicEnum.BoardSide.RED:
		side = TicEnum.BoardSide.BLUE
	else:
		side = TicEnum.BoardSide.RED
	
	on_side.emit.call_deferred(side)
	check_board(id)

func check_board(id: int):
	var lines = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
	var check_line= []
	for line in lines:
		if id in line:
			check_line.append(line)
	var base_side = cells[id].side
	for line in check_line:
		if cells[line[0]].side == base_side and cells[line[1]].side == base_side and cells[line[2]].side == base_side:
			emit_signal("on_finish",base_side)
			for cell in cells:
				cell.disabled = true
			return
	var full = true
	for cell in cells:
		if not cell.disabled:
			full = false
	if full:
		emit_signal("on_finish",-1)

func get_cells():
	return cells
