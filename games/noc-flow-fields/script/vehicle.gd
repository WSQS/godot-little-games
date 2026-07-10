extends SteeringBody
@onready var main: Node2D = $".."

var r := 8.0
var alpha := .0

func _ready() -> void:
	position = get_viewport().get_visible_rect().size / 2

func _compute_desired() -> Vector2:
	alpha += randf_range(-0.05, 0.05)
	return (Vector2(r * 6, 0) + Vector2.from_angle(alpha) * r * 2 + main.query_flow(position).rotated(-rotation) * 20).rotated(rotation)

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
	print(velocity, velocity.rotated(-rotation))
	draw_line(Vector2(), velocity.rotated(-rotation), Color.BLUE)
	draw_line(velocity.rotated(-rotation), _compute_desired().rotated(-rotation), Color.GREEN)
