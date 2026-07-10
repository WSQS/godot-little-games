extends SteeringAgent
class_name Boid
@onready var main: Node2D = $"../.."

var r := 8.0
var alpha := .0
var a := r * 2
var b := r
var c := r * sqrt(3)

var offset := Vector2(r * 6, 0)
var radius := r * 2

func _ready() -> void:
	var size := get_viewport().get_visible_rect().size
	position.x = randf_range(0, size.x)
	position.y = randf_range(0, size.y)

func _compute_desired() -> Vector2:
	alpha += randf_range(-0.05, 0.05)
	return (offset + Vector2.from_angle(alpha) * radius).rotated(rotation) + main.query_flow(position) * 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var size := get_viewport().get_visible_rect().size
	if position.x > size.x:
		position.x -= size.x
	elif position.x < 0:
		position.x += size.x
	if position.y > size.y:
		position.y -= size.y
	elif position.y < 0:
		position.y += size.y

func _draw_body() -> void:
	var pts = PackedVector2Array([
		Vector2(a, 0),
		Vector2(-b, -c),
		Vector2(-b, c)
	])
	draw_colored_polygon(pts, Color(0.5, 0.5, 0.5))
	pts.append(pts[0])
	draw_polyline(pts, Color.BLACK, 1.0)

func _draw_debug() -> void:
	draw_line(Vector2(a, 0), offset, Color.BLACK)
	draw_circle(offset, radius, Color.BLACK, false)
	draw_line(offset, offset + Vector2.from_angle(alpha) * radius, Color.BLACK)
	draw_line(Vector2.ZERO, velocity.rotated(-rotation), Color.BLUE)
	draw_line(offset + Vector2.from_angle(alpha) * radius, offset + Vector2.from_angle(alpha) * radius + main.query_flow(position).rotated(-rotation) * 20, Color.RED)
	draw_line(velocity.rotated(-rotation), _compute_desired().rotated(-rotation), Color.GREEN)
