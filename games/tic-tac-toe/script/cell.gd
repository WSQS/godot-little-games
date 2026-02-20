class_name Cell
extends Button


@export
var id:int
@export
var side:TicEnum.BoardSide = -1

signal cell_trigger(id:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _pressed() -> void:
	emit_signal("cell_trigger",id)

func flip(flip_side:TicEnum.BoardSide):
	side = flip_side
	var newbox = StyleBoxFlat.new()
	disabled = true
	if side == TicEnum.BoardSide.RED:
		newbox.bg_color = Color(1,0,0,0.6)
	else:
		newbox.bg_color = Color(0,0,1,0.6)
	add_theme_stylebox_override("disabled",newbox)
