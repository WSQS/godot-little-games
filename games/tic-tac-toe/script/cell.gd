class_name Cell
extends Button


@export
var id:int
@export
var side:GameEnum.BoardSide = -1

signal cell_trigger(cell:Cell,id:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _pressed() -> void:
	emit_signal("cell_trigger",self,id)
