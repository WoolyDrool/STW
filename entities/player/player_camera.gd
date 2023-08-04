extends Camera3D

@export var raycaster : RayCast3D

var interactLabel : Label
var modifierLabel : Label
var appendLabel : Label

@export var grabPoint : Node3D

var canGet
var x 

# Called when the node enters the scene tree for the first time.
func _ready():
	raycaster = $"AimCast"
	interactLabel = $"ImmediateUI/InteractText"
	modifierLabel = $"ImmediateUI/ModifierText"
	appendLabel = $"ImmediateUI/AppendText"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if raycaster.get_collider():
		x = raycaster.get_collider()
		
		#if x.has_signal("S_GENERAL_INTERACT"):
		#	canGet = true
		#else:
		#	canGet = false

		if x.has_method("Interact"):
			canGet = true
		else:
			canGet = false

		#if x:
		#	if x.get_children().has_node("Interact"):
		#		
		#		canGet = true
		#	else:
		#		canGet = false
			
		if canGet:
			interactLabel.text = (x.interactText)
			if x.modifierText : modifierLabel.text = "[" + x.modifierText + "]"
			if x.appendText : appendLabel.text = "(" + x.appendText + ")"
			if Input.is_action_just_pressed("interact_general"):
				x.Interact()
				x = null
				canGet = false
			elif Input.is_action_just_pressed("interact_grab"):
				print("grabbed " + x.name)
				x.global_position = lerp(x.global_position, grabPoint.global_position, 2 * delta)
	else:
		interactLabel.text = ""
		modifierLabel.text = ""
		appendLabel.text = ""
		canGet = false
		pass


