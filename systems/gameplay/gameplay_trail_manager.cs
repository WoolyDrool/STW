using Godot;
using System;
using System.Collections.Generic;

// This script is written in C# cause I'm more comfortable in it for writing a big mono class like this one is gonna
// end up being

public partial class gameplay_trail_manager : Node
{
	public float trailPercentage_Completed = 0;
	private float _trailPercentage_Maximum;
	//private List<Godot.Object> _pieces = new List<Godot.Object>();
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void TrailAddObjectiveScore(double score)
	{}

	public void TrailCalculateTotalScore()
	{}
}
