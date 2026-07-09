extends Node2D
@onready var main: Node2D = $".."

var r := 8.0
var alpha := .0
var v := Vector2()
var desired:= Vector2()

func _ready() -> void:
	position = get_viewport().get_visible_rect().size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	alpha += randf_range(-0.05, 0.05)
	desired = Vector2(r * 6, 0) + Vector2.from_angle(alpha) * r * 2 + main.query_flow(position).rotated(-rotation) * 20
	var f = (desired - v.rotated(-rotation)).rotated(rotation)
	v += f * delta
	rotation = v.angle()
	position += v * delta
	var size := get_viewport().get_visible_rect().size
	if position.x > size.x:
		position.x -= size.x
	elif position.x < 0:
		position.x += size.x
	if position.y > size.y:
		position.y -= size.y
	elif position.y < 0:
		position.y += size.y
	queue_redraw()

func _draw() -> void:
	var pts = PackedVector2Array([
		Vector2(r * 2, 0),
		Vector2(-r, -r * sqrt(3)),
		Vector2(-r, r * sqrt(3))
	])
	draw_colored_polygon(pts, Color(0.5, 0.5, 0.5))
	pts.append(pts[0])
	draw_polyline(pts, Color.BLACK, 1.0)
	draw_line(pts[0], pts[0] * 3, Color.BLACK)
	draw_circle(pts[0] * 3, r * 2, Color.BLACK, false)
	draw_line(pts[0] * 3, pts[0] * 3 + Vector2.from_angle(alpha) * r * 2, Color.BLACK)
	draw_line(Vector2(), v.rotated(-rotation), Color.BLUE)
	draw_line(v.rotated(-rotation), desired, Color.GREEN)
