extends GridContainer

var cells:Array[Cell]
var side:GameEnum.BoardSide = GameEnum.BoardSide.RED

@onready var label: Label = $"../../Label"

signal on_side(current_side: GameEnum.BoardSide)
signal on_finish(winner: GameEnum.BoardSide)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cell :PackedScene = load("res://scene/cell.tscn")
	emit_signal("on_side",side)
	if cell is PackedScene and cell.can_instantiate():
		for i in range(0,9):
			var cell_node:Cell = cell.instantiate()
			cell_node.id = i
			cell_node.cell_trigger.connect(process_cell_trugger)
			add_child(cell_node)
			cells.append(cell_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func process_cell_trugger(cell:Cell,id:int):
	prints(id)
	var newbox :StyleBoxFlat = StyleBoxFlat.new()
	cell.side = side
	if side == GameEnum.BoardSide.RED:
		newbox.bg_color = Color(1,0,0,0.6)
		side = GameEnum.BoardSide.BLUE
	else:
		newbox.bg_color = Color(0,0,1,0.6)
		side = GameEnum.BoardSide.RED
	
	cell.add_theme_stylebox_override("disabled",newbox)
	cell.disabled = true
	emit_signal("on_side",side)
	check_board(id)

func check_board(id: int):
	var lines = [[0,1,2]]
	var check_line= []
	for line in lines:
		if id in line:
			check_line.append(line)
	var base_side = cells[id].side
	for line in check_line:
		if cells[line[0]].side == base_side and cells[line[1]].side == base_side and cells[line[2]].side == base_side:
			emit_signal("on_finish",base_side)
			return
	var full = true
	for cell in cells:
		if not cell.disabled:
			full = false
	if full:
		emit_signal("on_finish",-1)
