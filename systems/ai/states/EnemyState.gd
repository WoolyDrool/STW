class_name EnemyState
extends AbstractState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready

