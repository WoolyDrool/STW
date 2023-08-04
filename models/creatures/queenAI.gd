extends Node3D

@onready var visionCone = $metarig/barrelSpine/Torso2/spine_012/Head/Vision

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_vision_timer_timeout():
	var overlaps = visionCone.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				print("I see you.")
