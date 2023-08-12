class_name EnemyState
extends AbstractState

var queen : QueenAI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	queen = owner as QueenAI
	assert(queen != null)
