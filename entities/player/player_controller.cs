using Godot;
using System;

public partial class player_controller : CharacterBody3D
{
	// Controller variables
	[Export] public float MAX_SPEED = 8;
	[Export] public float JUMP_SPEED = 5;
	[Export] public float ACCEL = 4.5f;
	[Export] public float DEACCEL= 16;
	[Export] public float MAX_SLOPE_ANGLE = 40;
	[Export] public float MOUSE_SENSITIVITY = 1;

	// Internal variables
	float GRAVITY = -(float)ProjectSettings.GetSetting("physics/3d/default_gravity");
	Vector3 vel;
	Vector3 dir;

	// Refs
	[Export] Camera3D camera;
	[Export] Node3D rotation_helper;

	// TODO ----
	// 1 Make angles/sliding feel better. Its very snappy and locky and Skyrim-y, for lack of a better word
	// 2 Implement a state machine of some kind
	// 3 Procedural headbob/crouch animations

	public override void _Ready()
	{
		if (camera == null)
			camera = (Camera3D)GetNode("Neck/Camera3D");
		if (rotation_helper == null)	
			rotation_helper = (Node3D)GetNode("Neck");

		Input.MouseMode = Input.MouseModeEnum.Captured;
	}

	public override void _PhysicsProcess(double delta)
	{
		process_input(delta);
		process_movement(delta);
	}

	void process_input(double delta)
	{
		// ----------------------------------
		// Walking
		var cam_xform = camera.GlobalTransform;

		Vector2 input_movement_vector;

		input_movement_vector = Input.GetVector("movement_back", "movement_forward", "movement_left", "movement_right").Normalized();

		// Basis vectors are already normalized.
		dir += -cam_xform.Basis.Z * -input_movement_vector.Y;
		dir += cam_xform.Basis.X * input_movement_vector.X;
		// ----------------------------------

		// ----------------------------------
		// Jumping
		if (IsOnFloor())
			if (Input.IsActionJustPressed("movement_jump"))
				vel.Y = JUMP_SPEED;
		// ----------------------------------

		// ----------------------------------
		// Capturing/Freeing the cursor
		if (Input.IsActionJustPressed("ui_cancel"))
		{
			if(Input.MouseMode == Input.MouseModeEnum.Visible)
				Input.MouseMode = Input.MouseModeEnum.Captured;
			else
				Input.MouseMode = Input.MouseModeEnum.Visible;
		}
		// ----------------------------------
	}
	void process_movement(double delta)
	{
		dir.Y = 0;
		dir = dir.Normalized();

		vel.Y += (float)delta * GRAVITY;

		var hvel = vel;
		hvel.Y = 0;

		var target = dir;
		target *= MAX_SPEED;

		float accel;
		if (dir.Dot(hvel) > 0)
			accel = ACCEL;
		else
			accel = DEACCEL;

		hvel = hvel.Lerp(target, accel * (float)delta);
		vel.X = hvel.X;
		vel.Z = hvel.Z;
		
		Velocity = vel;
		MoveAndSlide();
	}
	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseMotion mot && Input.MouseMode == Input.MouseModeEnum.Captured)
		{
			camera.RotateX(Mathf.DegToRad(-mot.Relative.Y * MOUSE_SENSITIVITY));
			rotation_helper.RotateY(Mathf.DegToRad(mot.Relative.X * MOUSE_SENSITIVITY * -1));
		}
	}
}
