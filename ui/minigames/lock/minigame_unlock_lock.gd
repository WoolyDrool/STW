extends Area2D

signal E_O_UNLOCKED

var unlocked : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_shape_entered(area_rid:RID, area:Area2D, area_shape_index:int, local_shape_index:int):
	if !unlocked:
		print("unlocked")
		emit_signal("E_O_UNLOCKED")
		unlocked = true
	pass # Replace with function body.
