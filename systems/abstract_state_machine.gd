extends Node

class_name AbstractStateMachine

var currentState : AbstractState
var nextState : AbstractState
var previousState : AbstractState

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ChangeState(state):
	if state.StateName != currentState.StateName:
		previousState = currentState
		previousState.Exit()
		currentState = state
		currentState.Enter()
		previousState = null

func QueueState(state):
	if state.StateName != previousState.StateName:
		nextState = state