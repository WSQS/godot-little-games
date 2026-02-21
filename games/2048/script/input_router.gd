extends Node

var position: Vector2

@onready var board: GridContainer = $"../VBoxContainer/AspectRatioContainer/Board"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.index != 0:
			return
		if event.is_pressed():
			position = event.position
			return
		var diff : Vector2 = event.position-position
		if diff.length() < 100:
			return
		if abs(diff.x) > abs(diff.y) * 2:
			if diff.x > 0:
				prints("right")
				handle("right")
			else:
				prints("left")
				handle("left")
		elif abs(diff.y) > abs(diff.x) *2:
			if diff.y > 0:
				prints("down")
				handle("down")
			else:
				prints("up")
				handle("up")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_LEFT:
				prints("left")
				handle("left")
			KEY_RIGHT:
				prints("right")
				handle("right")
			KEY_UP:
				prints("up")
				handle("up")
			KEY_DOWN:
				prints("down")
				handle("down")

func handle(input:String):
	board.swipe(input)
