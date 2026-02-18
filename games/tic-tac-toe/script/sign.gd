extends ResizeLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not label_settings:
		label_settings = LabelSettings.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_board_on_side(current_side: GameEnum.BoardSide) -> void:
	if current_side == GameEnum.BoardSide.RED :
		text = "red side"
		label_settings.font_color = Color(1,0,0,0.6)
	else:
		text = "blue side"
		label_settings.font_color = Color(0,0,1,0.6)


func _on_board_on_finish(winner: GameEnum.BoardSide) -> void:
	if winner == GameEnum.BoardSide.RED :
		text = "red win"
		label_settings.font_color = Color(1,0,0,0.6)
	elif winner == GameEnum.BoardSide.BLUE:
		text = "blue win"
		label_settings.font_color = Color(0,0,1,0.6)
	else:
		text = "draw"
		label_settings.font_color = Color(1,1,1,0.6)
