extends Node3D

@export var itemsInTree : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Will connect this via a signal function call later for easier initialisation
	# It probably will fail to load occasionally cause of variances in load order but
	# ¯\_(ツ)_/¯ 
	itemsInTree = get_child_count()
	#print(itemsInTree)
	EventBus.G_T_UPDATE_OBJECTIVE_COUNT.emit(itemsInTree)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
