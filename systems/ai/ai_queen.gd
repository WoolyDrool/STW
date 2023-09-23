extends CharacterBody3D

class_name QueenAI

@export var can_move = false
@export var can_see = true

@export var move_speed = 5
@export var move_accel = 10
@export var can_see_player = false
@export var target : Node3D = null

# Internal variables
@onready var visionCone = $Vision
@onready var visionCast = $VisionRaycast
@onready var nav_agent = $NavigationAgent3D

var update_target_position = true
var target_pos = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	nav_agent.max_speed = move_speed

func _physics_process(delta):
	if target && can_move:
		nav_agent.target_position = target.global_position
		
		if nav_agent.is_target_reachable() and not nav_agent.is_target_reached():
			var direction = nav_agent.get_next_path_position() - global_position
			direction = direction.normalized()
			
			velocity = velocity.lerp(direction * move_speed, move_accel * delta)
			
			move_and_slide()

func _on_vision_timer_timeout():
	if can_see:
		check_vision()

func check_vision():
	var overlaps = visionCone.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.is_in_group("Player"):
				var overlapPosition = overlap.global_transform.origin
				visionCast.look_at(overlapPosition, Vector3.UP)
				visionCast.force_raycast_update()
				
				var collider = visionCast.get_collider()
				print(collider)
				
				visionCast.debug_shape_custom_color = Color(174, 0, 0)
				target = collider as Node3D
			else:
				visionCast.debug_shape_custom_color = Color(0, 255, 0)
				print("Thats not the player")
