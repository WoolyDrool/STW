extends Node

class_name AIPath

@export var points = []
@export var looping : bool = true
var has_finished : bool = false
@export var path_index : int = 0
var path_total : int = 0
var first_node_pos : Vector3

# This is the signal that the queen sees
signal ai_path_update_next(nextpos : Vector3)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in self.get_children():
		points.append(child)
	
	if points.size() > 0:
		init_nodes()
	pass # Replace with function body.

func init_nodes():
	for i in points:
		var ai_node = i as AIPathNode 
		if ai_node.is_in_group("AIPathNodes"):
			if(ai_node.first):
				ai_node.index = path_total + 1
				first_node_pos = ai_node.global_position
			elif(ai_node.last):
				ai_node.index = points.size()
			else:
				ai_node.index = (path_total)
			
			path_total += 1
			
			ai_node.ai_arrived_at_node.connect(update_next)
			ai_node.on_init()
		
func update_next():
	path_index += 1
	var nextpos : Vector3
	if path_index < points.size():
		nextpos = points[path_index].global_position
	else:
		nextpos = first_node_pos
		path_index = 0
	
	ai_path_update_next.emit(nextpos)
	# update the queens next target to the next node position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
