# Code from Godot docs FPS tutorial

extends CharacterBody3D
class_name Player

# Controller variables
@export var MAX_SPEED = 20
@export var JUMP_SPEED = 18
@export var ACCEL = 4.5
@export var DEACCEL= 16
@export var MAX_SLOPE_ANGLE = 40

# Camera variables
@export var USE_SWAY : bool = true
@export var MOUSE_SENSITIVITY = 0.05
@export var MOUSE_SMOOTHING = 10
@export var CAM_SWAY : Vector3
@export var CAM_SWAY_NORMAL : Vector3
@export var CAM_SWAY_THRESH = 5
@export var CAM_SWAY_LERP = 5
var mousemov

# Internal variables
var GRAVITY = -ProjectSettings.get_setting("physics/3d/default_gravity")
var vel = Vector3()
var dir = Vector3()
var cam_input : Vector2
var rotation_velocity : Vector2

# Refs
@export var camera : Camera3D
@export var rotation_helper : Node3D

# TODO ----
# 1 Make angles/sliding feel better. Its very snappy and locky and Skyrim-y, for lack of a better word
# 2 Implement a state machine of some kind
# 3 Procedural headbob/crouch animations

func _ready():
	if !camera:
		camera = $CamHolder/Camera3D
	if !rotation_helper:	
		rotation_helper = $CamHolder

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta):
	# ----------------------------------
	# Walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()

	if Input.is_action_pressed("move_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("move_back"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("move_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_movement_vector.x += 1

	input_movement_vector = input_movement_vector.normalized()

	# Basis vectors are already normalized.
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x
	# ----------------------------------

	# ----------------------------------
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("move_jump"):
			vel.y = JUMP_SPEED
	# ----------------------------------

	# ----------------------------------
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# ----------------------------------

func process_movement(delta):
	# Gravity
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	# Acceleration
	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.lerp(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	
	velocity = vel
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		cam_input = event.relative
		mousemov = event.relative.x
		
func _process(delta):
	rotation_velocity = rotation_velocity.lerp(cam_input * MOUSE_SENSITIVITY, delta * MOUSE_SMOOTHING)
	camera.rotate_x(-deg_to_rad(rotation_velocity.y))
	rotation_helper.rotate_y(-deg_to_rad(rotation_velocity.x))

	_cam_sway(delta)

	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
	cam_input = Vector2.ZERO

func _cam_sway(delta):
	if USE_SWAY:
		# Camera Sway Z
		if mousemov != null:
			var finalSway 
			if mousemov > CAM_SWAY_THRESH:
				finalSway = rotation_helper.rotation.lerp(CAM_SWAY, CAM_SWAY_LERP * delta)
			elif mousemov < -CAM_SWAY_THRESH:
				finalSway = rotation_helper.rotation.lerp(-CAM_SWAY, CAM_SWAY_LERP * delta)
			else:
				finalSway = rotation_helper.rotation.lerp(CAM_SWAY_NORMAL, CAM_SWAY_LERP * delta)
			rotation_helper.rotation.z = finalSway.z
			#finalSway = 0
