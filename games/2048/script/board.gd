extends GridContainer

@export
var scene_block: PackedScene

var board_size:int =4

var data:Array[int] = []
var block: Array = []

var score: int = 0

signal on_score(score:int)

signal finished()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(16):
		var b = scene_block.instantiate()
		add_child(b)
		data.append(0)
		block.append(b)
		
	for i in range(2):
		add_block()
	
	sync()
	
	on_score.emit(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func swipe(direction: String):
	print(direction)
	var lines = split_line(direction)
	var b_merge = false
	for line in lines:
		if can_merge(line):
			b_merge = true
			break
	if not b_merge:
		return
	for i in range(len(lines)):
		lines[i] = merge(lines[i])
	write_back_lines(direction,lines)
	add_block()
	sync()
	check_ended()

func split_line(direction:String):
	var lines: Array[Array] = []

	for k in range(board_size):
		var idxs: Array[int]
		match direction:
			"left":
				idxs = [k*4 + 0, k*4 + 1, k*4 + 2, k*4 + 3]
			"right":
				idxs = [k*4 + 3, k*4 + 2, k*4 + 1, k*4 + 0]
			"up":
				idxs = [k + 0, k + 4, k + 8, k + 12]
			"down":
				idxs = [k + 12, k + 8, k + 4, k + 0]
			_:
				return []

		var line: Array[int] = []
		for id in idxs:
			line.append(data[id])
		lines.append(line)
	return lines

func write_back_lines(direction: String, merged_lines: Array[Array]) -> void:
	var n := board_size
	for k in range(n):
		var r: Array
		match direction:
			"left":
				r = range(k * n, k * n + n, 1)
			"right":
				r = range(k * n + (n - 1), k * n - 1, -1)
			"up":
				r = range(k, k + n * n, n)
			"down":
				r = range((n - 1) * n + k, k - 1, -n)
			_:
				return

		assert(merged_lines[k].size() == n)

		var j := 0
		for id in r:
			data[id] = merged_lines[k][j]
			j += 1

func merge(line:Array[int]):
	var de_empty : Array[int] = []
	for v in line:
		if v!=0:
			de_empty.append(v)
	var i : int = 1
	
	while i < len(de_empty):
		if de_empty[i-1] == de_empty[i]:
			score += de_empty[i] * 2
			on_score.emit(score)
			de_empty[i-1] *= 2
			de_empty.remove_at(i)
		i = i + 1
	while len(de_empty)<board_size:
		de_empty.append(0)
	return de_empty

func add_block():
	var indexs:Array[int] = []
	for i in range(len(data)):
		if data[i] == 0:
			indexs.append(i)
	data[indexs.pick_random()] = 2

func sync():
	for i in range(len(data)):
		block[i].set_value(data[i])

func can_merge(line:Array[int]):
	var i :int = 1
	while i < len(line):
		if line[i-1] == line[i] and line[i]!=0:
			return true
		if line[i-1] == 0 && line[i] != 0:
			return true
		i = i + 1
	return false

func check_ended():
	var b_merge = false
	for dir in ["left","right","up","down"]:
		var lines = split_line(dir)
		for line in lines:
			if can_merge(line):
				b_merge = true
				break
		if b_merge:
			break
	if not b_merge:
		finished.emit()
