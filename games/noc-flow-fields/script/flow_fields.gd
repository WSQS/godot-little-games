extends Node2D
var row := 0
var col := 0
var field := []
var resolution := 40
var noise = FastNoiseLite.new()
var time := .0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().size_changed.connect(generate_field)
	generate_field()

func _process(delta: float) -> void:
	time += delta * 10
	generate_field()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN

func generate_field() -> void:
	var size = get_viewport().get_visible_rect().size
	col = ceil(size.x / resolution)
	row = ceil(size.y / resolution)
	field = []
	for c in col:
		field.append([])
		for r in row:
			var n = noise.get_noise_3d(c * 10, r * 10, time)
			var angle = remap(n, -1, 1, 0, TAU)
			field[c].append(Vector2.from_angle(angle))
	queue_redraw()


func _draw() -> void:
	for c in col:
		for r in row:
			var center = Vector2(c * resolution, r * resolution) + Vector2(resolution / 2, resolution / 2)
			var dir = field[c][r]
			var diff = dir * resolution * 0.4
			var end = center + diff
			draw_line(center - diff, center + diff, Color.BLACK, 1.0)
			var perp = dir.rotated(PI / 2) * 2.0
			draw_line(end, end - dir * 4 + perp, Color.BLACK, 1.0)
			draw_line(end, end - dir * 4 - perp, Color.BLACK, 1.0)
