extends Area2D

var canClick : bool = false
var isHeld : bool = false
var mouseOffset

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isHeld:
		position = get_global_mouse_position() + mouseOffset
	pass

func _on_mouse_entered():
	canClick = true
	pass # Replace with function body.

func _on_grabbable_input_event(viewport:Node, event:InputEvent, shape_idx:int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouseOffset = position - get_global_mouse_position()
			isHeld = true
		else:
			isHeld = false

func _on_body_entered(body:Node2D):
	if body is $"Lock":
		print("height")
	pass # Replace with function body.
