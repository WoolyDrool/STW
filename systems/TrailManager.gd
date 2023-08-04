extends Node

@export var totalItemsInTrail : int

# Called when  vthe node enters the scene tree for the first time.
func _init():
	EventBus.G_T_UPDATE_OBJECTIVE_COUNT.connect(_update_objective_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _update_objective_count(value):
	#print("received value " + str(value))
	totalItemsInTrail += value
	print("new total " + (str(totalItemsInTrail)))
	
