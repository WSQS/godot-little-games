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

@export
var n_win: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	columns = n_col
	if cell is PackedScene and cell.can_instantiate():
		for i in range(0,n_row * n_col):
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

func generate_lines(i:int ,j: int):
	var result : Array[Array] = []
	for k in range(1-n_win,n_win):
		var fit:bool = true
		var line:Array[int] = []
		for a in range(0,n_win):
			var new_i = i - k + a
			if new_i < 0 or new_i >= n_row:
				fit = false
				break
			line.append(new_i * n_col + j)
		if fit:
			result.append(line)
		fit = true
		line = []
		for a in range(0,n_win):
			var new_j = j - k + a
			if new_j < 0 or new_j >= n_col:
				fit = false
				break
			line.append(i * n_col + new_j)
		if fit:
			result.append(line)
		fit = true
		line = []
		for a in range(0,n_win):
			var new_i = i - k + a
			var new_j = j - k + a
			if new_i < 0 or new_i >= n_row or new_j < 0 or new_j >= n_col:
				fit = false
				break
			line.append(new_i * n_col + new_j)
		if fit:
			result.append(line)
		fit = true
		line = []
		for a in range(0,n_win):
			var new_i = i - k + a
			var new_j = j + k - a
			if new_i < 0 or new_i >= n_row or new_j < 0 or new_j >= n_col:
				fit = false
				break
			line.append(new_i * n_col + new_j)
		if fit:
			result.append(line)
	return result

func check_board(id: int):
	var i = id / n_col
	var j = id % n_col
	prints("i",i,"j",j)
	var check_line= generate_lines(i,j)
	prints(check_line)
	var base_side = cells[id].side
	for line in check_line:
		var fit:bool = true
		for index in line:
			if cells[index].side != base_side:
				fit = false
				break
		if fit:
			emit_signal("on_finish",base_side)
			for i_cell in cells:
				i_cell.disabled = true
			return
	var full = true
	for i_cell in cells:
		if not i_cell.disabled:
			full = false
	if full:
		emit_signal("on_finish",-1)

func get_cells():
	return cells
