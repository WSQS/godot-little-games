extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(10):
		var vehicle = Boid.new()
		add_child(vehicle)
