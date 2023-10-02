extends Area3D

class_name AIPathNode

# This is the signal that the path manager sees
signal ai_arrived_at_node

var is_next : bool = false
@export var first : bool = false
@export var last : bool = false
var index : int = 0

func on_init():
	print(self, " is ", index)

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		print("she has arrivevd . . . ")
		is_next = false
		ai_arrived_at_node.emit()
	pass # Replace with function body.


func _on_body_exited(body):
	if body.is_in_group("Enemy"):
		print("she has left . . . ")
	pass # Replace with function body.
