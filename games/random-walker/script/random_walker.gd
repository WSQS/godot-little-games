extends Node2D

var walker_position = Vector2(0, 0)
var speed = 100

var line = Line2D.new()
var background = Line2D.new()
var head = Node2D.new()

func _ready() -> void:
	add_child(background)
	add_child(line)
	add_child(head)
	background.default_color = Color.BLACK
	background.width = 9
	line.width = 5
	var gradient := Gradient.new()
	gradient.set_color(0, Color.RED)
	gradient.set_color(1, Color.BLUE)
	line.gradient = gradient
	head.draw.connect(_draw_head)

func _draw_head() -> void:
	head.draw_circle(walker_position, 5, Color.ORANGE)
	head.draw_circle(walker_position, 3, Color.WHITE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	line.add_point(walker_position)
	background.add_point(walker_position)
	var step = delta * speed
	walker_position += Vector2(randf_range(-1, 1) * step, randf_range(-1, 1) * step)
	head.queue_redraw()
