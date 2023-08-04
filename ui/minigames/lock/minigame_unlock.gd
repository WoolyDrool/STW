extends Control

var phase2 : bool = false

var container1
var container2
var lock

# Called when the node enters the scene tree for the first time.
func _ready():
	container1 = $"Phase1"
	container2 = $"Phase2"
	lock = $"Phase1/Lock"

	container1.visible = true
	container2.visible = false
	lock.connect("E_O_UNLOCKED", _enter_phase2)
	EventBus.G_UI_MG_LOCK_START.connect(_start)
	EventBus.G_UI_MG_LOCK_END.connect(_end)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _start():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	visible = true


func _end():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false

func _enter_phase2():
	container1.visible = false
	container2.visible = true
