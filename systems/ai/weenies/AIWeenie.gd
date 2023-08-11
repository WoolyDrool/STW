extends Node

# So this is gonna be the class for things that Kour can see or interact with that will change her behaviour or goals
# I'm calling them weenies cause I remember this being a term for P.O.I in levels like towers/objectives
# And its funny

# I am writing the following code with no idea if any of it will actually be used, more sketching out the idea of what it needs

signal make_self_known # Ping itself to Kour for whatever reason
signal i_am_important # A higher priority version of make_self_known
signal forget_me # Maybe there will be a need for a weenie to ask Kour to ignore it instead
signal i_have_information # Maybe a node should only inform Kour of something, not request an action
signal do_specific_thing # A specific request to a function or something
signal stop_doing_this # A specific request to stop doing something

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func ping():
	# Ping kour, somehow
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
