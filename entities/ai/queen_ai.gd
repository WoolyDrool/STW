extends CharacterBody3D

class_name QueenAI

@export var can_move = false
@export var can_see = true

@export var move_speed : float = 5
@export var move_accel = 10
@export var too_close_dist = 1
@export var can_see_player = false
@export var target : Node3D = null

@export var using_path : bool = false
@export var current_path : AIPath
@export var queen_path_index : int

# Internal variables
@onready var visionCone = $Vision
@onready var visionCast = $VisionRaycast
@onready var nav_agent = $NavigationAgent3D

var update_target_position = true
var target_pos = Vector3()

# Initialization ////

func _ready():
	nav_agent.max_speed = move_speed
	
	# temp
	if using_path:
		begin_using_path()

func _physics_process(delta):
	if can_move:
		handle_agent_funcs(delta)

func begin_using_path():
	current_path.ai_path_update_next.connect(receive_next_path_pos)
	print(current_path)

# Main ////

func handle_agent_funcs(delta):
	if using_path:
		nav_agent.target_position = target_pos	
		# bad way of doing this but its for debug purposes
		look_at(nav_agent.get_next_path_position(), Vector3.UP, true)
	else:
		if target: 
			nav_agent.target_position = target.global_position
			
	if nav_agent.is_target_reachable() and not nav_agent.is_target_reached():
		var direction = nav_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * move_speed, move_accel * delta)
		
		move_and_slide()		
	
func receive_next_path_pos(new_pos : Vector3):
	target_pos = new_pos
	print(target_pos)


# Vision ////
func _on_vision_timer_timeout():
	if can_see:
		check_vision()

func check_vision():
	var overlaps = visionCone.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.is_in_group("Player") && !target:
				var overlapPosition = overlap.global_transform.origin
				visionCast.look_at(overlapPosition, Vector3.UP)
				visionCast.force_raycast_update()
				
				var collider = visionCast.get_collider()
				visionCast.debug_shape_custom_color =  Color(174, 0, 0, 23)
				target = collider as Node3D
			else:
				visionCast.debug_shape_custom_color = Color(0, 255, 0, 23)
