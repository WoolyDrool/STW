extends Node

# Stolen from GDQuest
# https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/

class_name AbstractState

@export var StateName : String = "Default"
var on : bool
var machine = null

# Virtual functions - called by the AbsctractStateMachine 

func handle_input(_event : InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(_delta:float) -> void:
	pass

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass


