extends Node2D
class_name SteeringBody

var velocity := Vector2.ZERO


func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAW:
		_draw_body()
		_draw_debug()
	elif what == NOTIFICATION_PROCESS:
		var desired = _compute_desired()
		var steer = desired - velocity
		var delta = get_process_delta_time()
		velocity += steer * delta
		position += velocity * delta
		rotation = velocity.angle()
		queue_redraw()

# abstract — subclasses must override this
func _compute_desired() -> Vector2:
	push_error("_compute_desired() must be overridden")
	printerr("_compute_desired() must be overridden")
	return Vector2.ZERO

func _draw_body() -> void:
	push_error("_draw_body() must be overridden")
	printerr("_draw_body() must be overridden")

func _draw_debug() -> void:
	pass # optional — no-op by default
