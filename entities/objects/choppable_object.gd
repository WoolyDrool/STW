extends Area3D

var health : int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_chop():
	health -= 1
	print("chopped")

	# Debug only, just so health can be visualised
	var m = $"Capsule"
	var mat = m.get_surface_override_material(0)
	if health == 2:
		mat.set_albedo(Color(0, 0, 1, 1))
	elif health == 1:
		mat.set_albedo(Color(1, 0, 0, 1))
	
	m.set_surface_override_material(0, mat)

	if health == 0:
		_chop_log()

func _chop_log():
	# Will eventually have it do things here
	queue_free()
