extends Node

# Also stolen from GDQuest 
# https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/

# TODO
# Add a queing system so multiple sates can execute in a set order
# Add the ability to run two states at once if needed

class_name AbstractStateMachine

signal transitioned(state_name) # Good for them

@export var initial_state := NodePath()
@onready var state: AbstractState = get_node(initial_state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	for child in get_children():
		if child.has_method("enter"):
			child.machine = self
	if state:		
		state.enter()

func _unhandled_input(event: InputEvent) -> void:
	if state:
		state.handle_input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state:
		state.update(delta)

func _physics_process(delta):
	if state:
		state.physics_update(delta)

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
	
	# If already in the requested state, do nothing
	if state.StateName == target_state_name:
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
