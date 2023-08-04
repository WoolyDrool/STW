extends Node3D

@export var locked : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.G_UI_MG_LOCK_END.connect(_finished)

	if locked:
		$"Interact".modifierText = "Locked"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _started():
	EventBus.G_UI_MG_LOCK_START.emit()

func _finished():
	$"Interact".modifierText = "Unlocked"

