extends GridContainer

@export_dir
var game_path:String

@export
var game_button: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dir = DirAccess.open(game_path)
	for d in dir.get_directories():
		var scene = load(game_path + "/" + d + "/scene/main.tscn")
		var g_b = game_button.instantiate()
		g_b.text = d
		g_b.game_scene = scene
		add_child(g_b)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
