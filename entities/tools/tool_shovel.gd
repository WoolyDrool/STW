extends UsableTool

func _ready():
	_get_nodes()

func _tool_primary() -> void:
	print("fired")
	canPrimary = false
	if primaryActionTimer:
		primaryActionTimer.start()
	
	if ray.get_collider():
		ray.get_collider()._on_flatten()
	

func _on_tool_primary_cooldown_timeout():
	canPrimary = true