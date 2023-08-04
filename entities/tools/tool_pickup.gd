extends Node3D

signal on_grabbed

@export var ResourcePath : String

func OnGrab():
    print("called")