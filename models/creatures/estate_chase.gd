extends EnemyState

@export var movement_speed = 5

func enter(_msg := {}) -> void:
	print("Entered Chase State")
	queen.can_move = true

func physics_update(delta: float) -> void:
	if queen.nav_agent.is_navigation_finished():
		return

	var current_agent_position: Vector3 = queen.global_position
	var next_path_position: Vector3 = queen.nav_agent.get_next_path_position()

	var new_velocity: Vector3 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed

	queen.velocity = new_velocity
