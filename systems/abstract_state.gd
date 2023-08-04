extends Node

class_name AbstractState

@export var StateName : String = "Default"
var on : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Enter():
	on = true
	pass

func _process(delta):
	if on:
		# do things
		pass

func Exit():
	on = false
	pass


