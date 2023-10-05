extends Node

var game_paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.game_pause.connect(pause_game)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func pause_game(paused : bool):
	get_tree().paused = paused
	game_paused = paused
