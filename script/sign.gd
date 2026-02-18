extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_board_on_side(current_side: GameEnum.BoardSide) -> void:
	if current_side == GameEnum.BoardSide.RED :
		text = "red side"
		add_theme_color_override("font_color",Color(1,0,0,0.6))
	else:
		text = "blue side"
		add_theme_color_override("font_color",Color(0,0,1,0.6))
