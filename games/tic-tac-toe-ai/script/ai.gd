extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_board_on_side(current_side: TicEnum.BoardSide) -> void:
	prints("_on_board_on_side",current_side)
	if current_side == TicEnum.BoardSide.BLUE:
		return
	var cells: Array[Cell] = get_parent().get_cells()
	var indexs: Array[int] = []
	for i in range(len(cells)):
		if cells[i].side == -1:
			indexs.append(i)
	if not indexs.is_empty():
		prints("_on_board_on_side 1")
		get_parent().process_cell_trugger(indexs.pick_random())
	pass
