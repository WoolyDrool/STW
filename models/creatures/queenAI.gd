extends CharacterBody3D

class_name QueenAI

@export var can_move = false
@export var can_see = true

@export var move_speed = 5
@export var can_see_player = false

# Internal variables
@onready var visionCone = $Vision
@onready var nav_agent = $NavigationAgent3D
@onready var asm = $AbstractStateMachine
var update_target_position = true
@export var target : Node3D = null
var target_pos = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	nav_agent.path_desired_distance = 0.5
	nav_agent.target_desired_distance = 0.5
	
	call_deferred("agent_setup")

func agent_setup():
	await get_tree().physics_frame
	
func set_movement_target(move_target : Vector3):
	nav_agent.set_target_position(move_target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move && target != null:
		set_target_position()
	pass

func _physics_process(delta):
	if can_move:
		move_and_slide()

func set_target_position():
	target_pos = target.global_position

func _on_vision_timer_timeout():
	if can_see:
		check_vision()

func check_vision():
	var overlaps = visionCone.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				var playerPosition = overlap.global_transform.origin
				$VisionRaycast.look_at(playerPosition, Vector3.UP)
				$VisionRaycast.force_raycast_update()
				
				if $VisionRaycast.is_colliding():
					var collider = $VisionRaycast.get_collider()
					
					if collider.name == "Player":
						$VisionRaycast.debug_shape_custom_color = Color(174, 0, 0)
						asm.transition_to("Chase")
					else:
						$VisionRaycast.debug_shape_custom_color = Color(0, 255, 0)
						print("Thats not the player")
